library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ripple_carry_adder_tb is

end ripple_carry_adder_tb;

architecture tb of ripple_carry_adder_tb is
	component ripple_carry_adder is
			generic (N	: INTEGER);
			port (a 		: in STD_LOGIC_VECTOR(N - 1 downto 0);
					b		: in STD_LOGIC_VECTOR(N - 1 downto 0);
					sum	: out STD_LOGIC_VECTOR(N downto 0));
	end component;
	
	signal clk			: STD_ULOGIC := '0';
	
	signal tt_a			: STD_LOGIC_VECTOR(3 downto 0);
	signal tt_b 		: STD_LOGIC_VECTOR(3 downto 0);
	signal tt_sum		: STD_LOGIC_VECTOR(4 downto 0);
	signal tt_rtl_sum : STD_LOGIC_VECTOR(4 downto 0);
begin
	DUT_ripple_carry_adder : ripple_carry_adder generic map (N => 4)
															  port map (a => tt_a,
																			b => tt_b,
																			sum => tt_sum);
																			
	clk <= not clk after 5 ns;
	process
	begin
		wait for 10 ns;
			for i in 0 to 16 loop
				tt_a <= std_logic_vector(to_unsigned(i, tt_a'length));
				tt_b <= std_logic_vector(to_unsigned(i, tt_b'length));
				wait for 10 ns; -- signal changes need to propagate
				tt_rtl_sum <= std_logic_vector(resize(unsigned(tt_a), tt_a'length + 1) + resize(unsigned(tt_b), tt_a'length + 1));
				wait for 10 ns;
				assert tt_sum = tt_rtl_sum
					report "The sum is not equal; sum = " & integer'image(to_integer(unsigned(tt_sum))) & " expected = " & integer'image(to_integer(unsigned(tt_rtl_sum))) & " at idx = " & integer'image(i)
					severity error;
			end loop;
	end process;
end tb;