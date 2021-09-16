library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	generic (N : INTEGER := 4); -- lol default value??
	port (OP		: in STD_LOGIC_VECTOR(2 downto 0);
			A		: in STD_LOGIC_VECTOR(N - 1 downto 0);
			B		: in STD_LOGIC_VECTOR(N - 1 downto 0);
			Sum	: out STD_LOGIC_VECTOR(N - 1 downto 0);
			Z_Flag: out STD_LOGIC;
			N_Flag: out STD_LOGIC;
			O_Flag: out STD_LOGIC);
end ALU;

architecture data_flow of ALU is -- should it be called behavioral?
	type t_operation is (OP_ADD, OP_SUB, OP_AND, OP_OR, OP_XOR, OP_NOT, OP_MOV, OP_Zero);
begin
	proc : process(OP, A, B)
	begin
		case (t_operation'val(to_integer(unsigned(OP)))) is
			when OP_ADD => Sum <= std_logic_vector(unsigned(A) + unsigned(B));
			when OP_SUB => Sum <= std_logic_vector(unsigned(A) - unsigned(B));
			when OP_AND => Sum <= A and B;
			when OP_OR 	=> Sum <= A or B;
			when OP_XOR => Sum <= A xor B;
			when OP_NOT => Sum <= not A;
			when OP_MOV => Sum <= A;
			when OP_Zero=> Sum <= (others => '0');
		end case;
	
	-- flags
	end process proc;
end data_flow;