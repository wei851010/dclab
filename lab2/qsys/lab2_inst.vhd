	component lab2 is
		port (
			clk_clk                        : in  std_logic := 'X'; -- clk
			reset_reset_n                  : in  std_logic := 'X'; -- reset_n
			uart_0_external_connection_RXD : in  std_logic := 'X'; -- RXD
			uart_0_external_connection_TXD : out std_logic         -- TXD
		);
	end component lab2;

	u0 : component lab2
		port map (
			clk_clk                        => CONNECTED_TO_clk_clk,                        --                        clk.clk
			reset_reset_n                  => CONNECTED_TO_reset_reset_n,                  --                      reset.reset_n
			uart_0_external_connection_RXD => CONNECTED_TO_uart_0_external_connection_RXD, -- uart_0_external_connection.RXD
			uart_0_external_connection_TXD => CONNECTED_TO_uart_0_external_connection_TXD  --                           .TXD
		);

