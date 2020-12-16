library IEEE;
use IEEE.std_logic_1164.all;

use work.fixed_float_types.all;
use work.fixed_pkg.all;
use work.types_and_constants.all;

entity tb_two_neuron is
end tb_two_neuron;

architecture test of tb_two_neuron is

    signal clk : std_logic := '0';
    signal rst : std_logic;
    signal data_in : sfixed_array := (to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(3.0, intbits-1, -fracbits), to_sfixed(4.0, intbits-1, -fracbits),
                                        to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits), to_sfixed(-3.0, intbits-1, -fracbits), to_sfixed(-4.0, intbits-1, -fracbits));
    signal result : sfixed_array;

begin

    dut: entity work.two_neuron
        port map(clk, rst, data_in, result);

    clk <= not clk after 5 ns;

    process
    begin
        rst <= '1';

        wait for 5 ns;

        rst <= '0';

        wait for 200 ns;

        -- Result should be equal to the bias, as weights * data_in = 0

    end process;

end test;