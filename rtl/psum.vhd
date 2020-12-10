library IEEE;
use IEEE.std_logic_1164.all;

use work.fixed_float_types.all;
use work.fixed_pkg.all;
use work.types_and_constants.all;

entity psum is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        data_in : in sfixed(intbits-1 downto -fracbits);
        weight  : in sfixed(intbits-1 downto -fracbits);
        bias    : in sfixed(intbits-1 downto -fracbits);
        step    : in integer range 0 to n;
        result  : out sfixed(intbits-1 downto -fracbits)
    );
end psum;


architecture behavior of psum is

    signal relu_in : sfixed(intbits-1 downto -fracbits);
    signal acc : sfixed(psum_intbits downto -2*fracbits);

begin

    process (clk, rst)
    begin
        if rst = '1' then
            relu_in <= to_sfixed(0, intbits-1, -fracbits);
            acc <= to_sfixed(0, psum_intbits, -2*fracbits);
        elsif rising_edge(clk) then
            if step = 0 then  -- Initialize the accumulation register with the bias
                acc <= resize(bias, psum_intbits, -2*fracbits);
            elsif step = n then  -- Accumulate last value and send the result to the activation function
                acc <= resize(acc + (data_in * weight), psum_intbits, -2*fracbits);
                relu_in <= resize(acc, intbits-1, -fracbits);
            else  -- Accumulate next value
                acc <= resize(acc + (data_in * weight), psum_intbits, -2*fracbits);
            end if;
        end if;
    end process;

    activation: entity work.ReLU
        port map(relu_in, result);

end behavior;
