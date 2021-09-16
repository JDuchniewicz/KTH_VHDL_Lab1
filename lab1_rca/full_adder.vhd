library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
	port (a 		: in STD_LOGIC;
			b		: in STD_LOGIC;
			c_in	: in STD_LOGIC;
			sum	: out STD_LOGIC;
			c_out	: out STD_LOGIC);
end full_adder;

architecture data_flow of full_adder is
begin
	sum <= a xor b xor c_in;
	c_out <= (a and c_in) or (a and b) or (b and c_in);
end data_flow;