use work.fixed_float_types.all;
use work.fixed_pkg.all;
use work.types_and_constants.all;

entity tb_neuron is
end tb_neuron;

architecture test of tb_neuron is

    signal data_in : sfixed_array;
    signal weights : sfixed_array;
    signal bias    : sfixed(intbits-1 downto -fracbits);
    signal result  : sfixed(intbits-1 downto -fracbits);

begin

    dut: entity work.neuron
        port map(data_in, weights, bias, result);

    process
    begin
        data_in <= (others => to_sfixed(0, intbits-1, -fracbits));
        weights <= (others => to_sfixed(0, intbits-1, -fracbits));
        bias <= to_sfixed(0, intbits-1, -fracbits);

        wait for 5 ns;

        data_in <= (to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(3.0, intbits-1, -fracbits), to_sfixed(4.0, intbits-1, -fracbits),
                    to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits), to_sfixed(-3.0, intbits-1, -fracbits), to_sfixed(-4.0, intbits-1, -fracbits));
        weights <= (to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits),
                    to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits));
        bias <= to_sfixed(1.0, intbits-1, -fracbits);
        -- Result should be equal to the bias, as weights * data_in = 0

        wait for 10 ns;

        data_in <= (others => to_sfixed(0, intbits-1, -fracbits));
        weights <= (others => to_sfixed(0, intbits-1, -fracbits));
        bias <= to_sfixed(0, intbits-1, -fracbits);
    end process;

end test;