//return (a^e)modn
`timescale 1ns/100ps
module Rsa256Core(
	input i_clk,
	input i_rst,
	input i_start,
	input [255:0] i_a,
	input [255:0] i_e,
	input [255:0] i_n,
	output [255:0] o_a_pow_e,
	output o_finished
);
    enum{IDLE, MOD_PROD, MONT, MONT_CAL, DONE} state_r, state_w;

    logic[255:0]  ans_r, ans_w, y_tmp_w, y_tmp_r;
    logic[255:0]  a_r, a_w, e_r, e_w, n_r, n_w;
    logic[8:0]    rsa_counter_r, rsa_counter_w;
    logic[1:0]    mc_w, mc_r; //montgomery count, to check if the 2 montgomerys are finished
    logic         total_finish_w, total_finish_r;

    logic         modp_start_r,  modp_start_w;
    logic         modp_finish;
    logic[255:0]  modp_ans;

    logic        mont1_start_r,   mont1_start_w,   mont2_start_r,   mont2_start_w;
    logic        mont1_finish,    mont2_finish;
    logic[255:0] mont1_ans,       mont2_ans;
    logic[255:0] mont1_a_w,       mont1_a_r,       mont1_b_r,       mont1_b_w;
    logic[255:0] mont2_a_w,       mont2_a_r,       mont2_b_r,       mont2_b_w;
    
    assign o_finished = total_finish_r;
    assign o_a_pow_e  = ans_r;
    ModuloOfProduct modp(.i_start(modp_start_r), 
                         .i_clk(i_clk),
                         .i_rst(i_rst),
                         .b({1'b0,a_r}),
                         .a({{1'b1},{256{1'b0}}}),
                         .N({1'b0,n_r}),
                         .ans(modp_ans),
                         .o_finished(modp_finish)
                         );

    Montgomery mont1(.i_start(mont1_start_r),
                     .i_clk(i_clk),
                     .i_rst(i_rst),
                     .a(mont1_a_r),
                     .b(mont1_b_r),
                     .N(n_r),
                     .ans(mont1_ans),
                     .o_finished(mont1_finish) 
                     );
    Montgomery mont2(.i_start(mont2_start_r),
                     .i_clk(i_clk),
                     .i_rst(i_rst),
                     .a(mont2_a_r),
                     .b(mont2_b_r),
                     .N(n_r),
                     .ans(mont2_ans),
                     .o_finished(mont2_finish)
                     ); 
    always_comb begin
        state_w =   state_r;
        ans_w   =   ans_r; 
        y_tmp_w =   y_tmp_r;
        a_w     =   a_r; 
        e_w     =   e_r; 
        n_w     =   n_r;
        rsa_counter_w = rsa_counter_r;
        mc_w    =   mc_r;
        total_finish_w = total_finish_r;

        modp_start_w =  modp_start_r;
        mont1_start_w =   mont1_start_r;   
        mont2_start_w =   mont2_start_r;

        mont1_a_w   =   mont1_a_r;       
        mont1_b_w   =   mont1_b_r;
        mont2_a_w   =   mont2_a_r;       
        mont2_b_w   =   mont2_b_r;

        case(state_r) 
        MOD_PROD: begin
            if (modp_finish == '1)begin //is this right?
                state_w = MONT;
                y_tmp_w = modp_ans;
            end 
            modp_start_w = '0;
        end
        MONT: begin
            modp_start_w = '0;//is this valid?
            if (e_r[rsa_counter_r] == 1) begin
                mont1_a_w = ans_r;
                mont1_b_w =y_tmp_r;
		mont1_start_w = '1;
            end else 
                mc_w = mc_r +1; 
            mont2_start_w = '1;
            mont2_a_w = y_tmp_r;
            mont2_b_w = y_tmp_r;
        
            state_w = MONT_CAL; 
        end
        MONT_CAL: begin
            mont1_start_w = '0;
            mont2_start_w = '0;
            if (mont1_finish) begin
                mc_w[0] = 1;
                ans_w = mont1_ans;
            end 
            if (mont2_finish) begin
                mc_w[1] = 1;
                y_tmp_w = mont2_ans;
            end 
            if (mc_r == 3) begin
                if (rsa_counter_r == 255) begin
                    state_w = DONE;
                    total_finish_w = '1;
                    mc_w = '0;
                    rsa_counter_w ='0;
                end 
                else begin
                    state_w = MONT;
                    mc_w = '0;
                    rsa_counter_w = rsa_counter_r+1;
                end 
            end 
        end
        DONE: begin
            state_w = IDLE;
            total_finish_w = '0;
        end 
        IDLE: begin
            total_finish_w = '0;
            ans_w =ans_r; 
	        if (i_start)begin
			state_w =   MOD_PROD;
			ans_w   =   256'b1;
            		y_tmp_w =   '0;
            		a_w     =   i_a; 
            		e_w     =   i_e; 
            		n_w     =   i_n;
            		rsa_counter_w = '0;
            		mc_w    =   '0;
            		total_finish_w = '0;
    
            		modp_start_w =  '1;
            		mont1_start_w =   '0;   
            		mont2_start_w =   '0;
    
            		mont1_a_w   =   '0;       
            		mont1_b_w   =   '0;
            		mont2_a_w   =   '0;       
            		mont2_b_w   =   '0;
        		end 
        end
       endcase	
    end 
    always_ff@(posedge i_clk or posedge i_rst) begin
        if (i_rst)begin
            state_r <= IDLE;
            ans_r <= 256'b1;
            y_tmp_r <= '0;
            a_r <= '0;
            e_r <= '0;
            n_r <='0;
            rsa_counter_r <= '0;
            mc_r <= '0;
            total_finish_r <= '0;
            modp_start_r <= '0;
            mont1_start_r <= '0;
            mont2_start_r <= '0;
            mont1_a_r <= '0;
            mont1_b_r <= '0;
            mont2_a_r <= '0;
            mont2_b_r <= '0;
        end
        else begin
            state_r <= state_w;
            ans_r <= ans_w;
            y_tmp_r <= y_tmp_w;
            a_r <= a_w;
            e_r <= e_w;
            n_r <=n_w;
            rsa_counter_r <= rsa_counter_w;
            mc_r <= mc_w;
            total_finish_r <= total_finish_w;
            modp_start_r <= modp_start_w;
            mont1_start_r <= mont1_start_w;
            mont2_start_r <= mont2_start_w;
            mont1_a_r <= mont1_a_w;
            mont1_b_r <= mont1_b_w;
            mont2_a_r <= mont2_a_w;
            mont2_b_r <= mont2_b_w;
        end 
    end 
    

endmodule
//returns (a*b) mod N
//can't use montgomery here becasue whenever one uses montgomery,
//there is a 2^-256 scaling factor
`timescale 1ns/100ps
module ModuloOfProduct(
    input i_start,
    input i_clk,
    input i_rst,
    input [256:0] a,
    input [256:0] b,//2^256
    input [256:0] N,
    output [255:0] ans,
    output o_finished 
    );
    enum{IDLE, DONE, RUN} state_r, state_w;
    logic [8:0] counter_r,counter_w; // counter must count till 256, because b will be 2^256, 
    logic [256:0] b_dbl_r, b_dbl_w; // these variables will be assigned with b initially
    logic [256:0] tmp_1; //this is to implement the "times two"
    logic [256:0] m_r, m_w;
    logic done_r, done_w;
    assign ans = m_r[255:0];
    assign o_finished = done_r;
    assign tmp_1 = b_dbl_r <<1; //by shifting left, tmp_1 = b_dbl_r * 2
    always_comb begin
        case(state_r) 
           RUN:   
           begin
                counter_w = counter_r + 1;
//                if (a[counter_r] == 1) begin
//                    if (m_r + b_dbl_r >= N)
//                        m_w = m_r + b_dbl_r - N;
//                    else 
//                        m_w = m_r + b_dbl_r;
                    if (tmp_1 >= N)
                        b_dbl_w = tmp_1 -N;
                    else
                        b_dbl_w = tmp_1; 
//                end 
//                else begin
                    m_w = m_r;
//                    b_dbl_w = b_dbl_r;
//                end

                if (counter_r == 9'd255) begin
                    state_w = DONE;
                    done_w = '1;
		    if (b_dbl_r >= N)
			    m_w = b_dbl_w - N;
		    else 
			    m_w = b_dbl_w;
                end else begin
                    state_w = RUN;
                    done_w = '0;
                end 
            end

           DONE: 
           begin
            done_w = '0;
            state_w = IDLE;
            m_w = m_r;
            counter_w = counter_r;
            b_dbl_w = b_dbl_r;
            end

           IDLE: 
           begin //state_r == IDLE
            if (i_start) begin
                state_w = RUN;
                counter_w = '0;
                b_dbl_w = b;
                m_w = '0;
                done_w = '0;
            end else begin 
                state_w = IDLE;
                done_w = '0;
                m_w = m_r;
                counter_w = '0;
                b_dbl_w = '0;
                end
            end 
    endcase
     end 

    always_ff@(posedge i_clk or posedge i_rst) begin
        if (i_rst) begin
            state_r <= IDLE;
            counter_r <= '0;
            b_dbl_r <= b;
            m_r <= '0;
            done_r <= '0;
        end
        else begin
            state_r <= state_w; 
            counter_r <= counter_w;
            b_dbl_r <= b_dbl_w;
            m_r <= m_w;
            done_r <=done_w;
        end 
    end 
endmodule 

//returns (a*b) mod N
//implements the montgomery algorithm
`timescale 1ns/100ps
module Montgomery(input i_start,
                  input i_clk,
                  input i_rst,
                  input [255:0] a,
                  input [255:0] b,
                  input [255:0] N,
                  output [255:0] ans,
                  output o_finished  
                  );

    enum {IDLE, DONE, RUN} state_w, state_r;
    logic [257:0] result_w, result_r;
    logic [257:0] cal_w, cal_r;
    logic [255:0] a_w, a_r, b_w, b_r, N_w, N_r;
    logic [257:0] tmp_1, tmp_2; //this is to record the "if" combinational circuit
    logic         done_r, done_w;
    logic [8:0]   counter_w, counter_r;


    assign ans = result_r[255:0];
    assign o_finished = done_r;
    assign tmp_1 = (a_r[counter_r])?(cal_r + b_r):(cal_r);
    assign tmp_2 = (tmp_1[0]==1)?(tmp_1+N_r):tmp_1;
    always_comb begin
        a_w = a_r;
        b_w = b_r;
        N_w = N_r;
        case(state_r)
        RUN: begin            
            counter_w = counter_r+1;
            cal_w = tmp_2 >> 1; //m_w is devided by 2
            if (counter_r == 255) begin//check here can I write: if (counter_w == 8'd255)
                if (cal_w >= N_r) //check here or should I write: if (m_r>>1 >=N)
                    result_w = cal_w - N_r;
                else 
                    result_w = cal_w;
                state_w = DONE;
                done_w = 1'b1; 
            end

            else begin
                result_w = cal_r;
                state_w = RUN;
                done_w = 1'b0;
            end  
            end 

       DONE: begin
            state_w = IDLE;
            done_w = 1'b0;
            cal_w = cal_r;
            counter_w = counter_r;
            result_w = result_r;
            end 
       IDLE: begin 
            if(i_start) begin
                a_w = a;
                b_w = b;
                N_w = N;
                state_w = RUN;
                counter_w = '0;
                cal_w = '0;
                done_w = 1'b0;
                result_w = '0;
            end else begin 
                state_w = IDLE;
                done_w = done_r;
                cal_w = cal_r;
                counter_w = counter_r;
                result_w = result_r;
                end
            end 
	endcase	

    end 
    always_ff@(posedge i_clk or posedge i_rst) begin
        if (i_rst) begin
            counter_r <= '0;
            cal_r <= '0;
            state_r <= IDLE;
            done_r <= '0;
            result_r <= '0;
            a_r <= '0;
            b_r <= '0;
            N_r <= '0;
        end 
        else begin
            a_r <= a_w;
            b_r <= b_w;
            N_r <= N_w;
            counter_r <= counter_w;
            cal_r <= cal_w;
            state_r <= state_w;
            done_r <= done_w;
            result_r <=result_w;
        end 
    end
endmodule 
