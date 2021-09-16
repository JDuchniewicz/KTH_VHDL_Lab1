library ieee;
use ieee.std_logic_1164.all;
--use work.full_adder.all; -- it is not a package!

entity ripple_carry_adder is
	generic (N	: INTEGER);
	port (a 		: in STD_LOGIC_VECTOR(N - 1 downto 0);
			b		: in STD_LOGIC_VECTOR(N - 1 downto 0);
			sum	: out STD_LOGIC_VECTOR(N downto 0));
end ripple_carry_adder;

architecture structure of ripple_carry_adder is
	component full_adder is 
		port (a 		: in STD_LOGIC;
				b		: in STD_LOGIC;
				c_in 	: in STD_LOGIC;
				sum	: out STD_LOGIC;
				c_out : out STD_LOGIC);
	end component;
	signal carry : STD_LOGIC_VECTOR(N downto 0);
	signal subsum : STD_LOGIC_VECTOR(N - 1 downto 0);
begin
	carry(0) <= '0'; -- initialize carry
	G1: for i in 0 to N - 1 generate -- generate bits from right to left
		full_array : full_adder
			port map (a => a(i), b => b(i), c_in => carry(i), sum => subsum(i), c_out => carry(i + 1)); -- are the bits properly ordered?
	end generate G1;
	-- result is the sum and MSB
	sum <= carry(N) & subsum;
end structure;