library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity Multiplication_4bit is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Res : out STD_LOGIC_VECTOR (7 downto 0));
end Multiplication_4bit;

architecture Behavioral of Multiplication_4bit is
begin
    Res <= std_logic_vector(unsigned(A) * unsigned(B));
end Behavioral;
 
