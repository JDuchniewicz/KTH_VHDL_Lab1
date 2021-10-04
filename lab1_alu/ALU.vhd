library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	generic (N : INTEGER := 4); -- default value??
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

    function nor_reduction(vec : IN STD_LOGIC_VECTOR) return STD_LOGIC is
        variable v_res : STD_LOGIC := '1';
    begin
        for i in vec'range loop
            v_res := v_res nor vec(i);
        end loop;
        return v_res;
    end function;

begin
	proc : process(OP, A, B)
		variable v_Sum :    STD_LOGIC_VECTOR(N - 1 downto 0);
	begin
		case (t_operation'val(to_integer(unsigned(OP)))) is
			when OP_ADD => v_Sum := std_logic_vector(unsigned(A) + unsigned(B));
			when OP_SUB => v_Sum := std_logic_vector(unsigned(A) - unsigned(B));
			when OP_AND => v_Sum := A and B;
			when OP_OR 	=> v_Sum := A or B;
			when OP_XOR => v_Sum := A xor B;
			when OP_NOT => v_Sum := not A;
			when OP_MOV => v_Sum := A;
			when OP_Zero=> v_Sum := (others => '0');
		end case;

	Sum <= v_Sum;
	-- flags
    Z_Flag <= nor_reduction(v_Sum); -- need a function for reduction because quartus does not implement unary operators -.-
	N_Flag <= v_Sum(N - 1) and '1';
    -- this could be implemented easier if we know the carry value but it is implemented by the compiler
    if (A(N - 1) = '1' and B(N - 1) = '1') then -- if bits before are the same but the result is different we have overflow
        if v_Sum(N - 1) = '0' then
            O_Flag <= '1';
        else
            O_Flag <= '0';
        end if;
    elsif (A(N - 1) = '0' and B(N - 1) = '0') then
        if v_Sum(N - 1) = '1' then
            O_Flag <= '1';
        else
            O_Flag <= '0';
        end if;
    else
        O_Flag <= '0';
    end if;
	end process proc;
end data_flow;
