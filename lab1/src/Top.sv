module Top(
	input i_clk,
	input i_rst,
	input i_start,
	output [3:0] o_random_out
);
`ifdef FAST_SIM
	parameter FREQ_HZ = 1000;
`elsif
	parameter FREQ_HZ = 50000000;
`endif

	enum {IDLE, RUN} state_w, state_r;
	logic [31:0] counter_w, counter_r;
	logic [3:0]  random_w, random_r;
	logic [31:0] random_seed_w, random_seed_r;
	logic [3:0]  num_counter_w, num_counter_r;
	logic [15:0] [0:3] array_w, array_r; 
	
	assign o_random_out = array_w [random_r];

	always_comb begin

		if (state_r == IDLE) begin
			random_w = random_r;
			state_w = IDLE;
			counter_w = 0;
			random_seed_w = random_seed_r;
			num_counter_w = num_counter_r;
			array_w = array_r;
		end else begin
			counter_w = counter_r + 1;
			array_w = array_r;
			num_counter_w = num_counter_r;
			case(counter_r)
				 5000000,
				10000000,
				15000000,
				20000000,
				25000000,
				30000000,
				37000000,
				46000000,
				57000000,
				70000000,
				85000000,
				102000000,
				121000000,
				142000000: 	begin
									random_seed_w = random_seed_r * 499139 % 2147483647;
									random_w = random_seed_r[18:7] % (num_counter_r+1);
									state_w = state_r;
								end

				142000001:	begin
									state_w = IDLE;
									random_w = random_r;
									random_seed_w = random_seed_r;
								end
						default: begin
									random_w = random_r;
									state_w = state_r;
									random_seed_w = random_seed_r;
									end
					endcase
		end
		if (i_start) begin
			state_w = RUN;
			counter_w = 0;
			if (num_counter_r == 0) begin
				num_counter_w = 15;
				array_w = '{4'hf, 4'he, 4'hd, 4'hc, 4'hb, 4'ha, 4'h9, 4'h8, 4'h7, 4'h6, 4'h5, 4'h4, 4'h3, 4'h2, 4'h1, 4'h0};
			end else begin
				num_counter_w = num_counter_r-1;
				array_w[random_r] = array_r[num_counter_r];
			end
		end
	end


	always_ff @(posedge i_clk or negedge i_rst) begin
		if (!i_rst) begin
			state_r <= IDLE;
			random_r <= 0;
			counter_r <= 0;
			random_seed_r <= $urandom;
			num_counter_r <= 15;
			array_r <= '{4'hf, 4'he, 4'hd, 4'hc, 4'hb, 4'ha, 4'h9, 4'h8, 4'h7, 4'h6, 4'h5, 4'h4, 4'h3, 4'h2, 4'h1, 4'h0};
			end
		else begin
			counter_r <= counter_w;
			state_r <= state_w;
			random_r <= random_w;
			random_seed_r <= random_seed_w;
			num_counter_r <= num_counter_w;
			array_r <= array_w;
			end
	end
endmodule
