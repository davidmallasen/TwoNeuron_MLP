use work.fixed_float_types.all;
use work.fixed_pkg.all;
use work.types_and_constants.all;

entity neuron is
    port (
        data_in : in sfixed_array;
        weights : in sfixed_array;
        bias    : in sfixed(intbits-1 downto -fracbits);
        result  : out sfixed(intbits-1 downto -fracbits)
    );
end neuron;


architecture behavior of neuron is

    type mult_out_t is array (n-1 downto 0) of sfixed(2*intbits-1 downto -2*fracbits);
    signal mult_out : mult_out_t;

    signal relu_in : sfixed(intbits-1 downto -fracbits);

begin

    mult_gen: for i in 0 to n-1 generate
        mult_out(i) <= data_in(i) * weights(i);
    end generate;

    process (bias, mult_out)  -- Synthesize as adder tree
        variable acc : sfixed(psum_intbits downto -2*fracbits);
    begin
        acc := resize(bias, psum_intbits, -2*fracbits);
        for i in 0 to n-1 loop
            acc := resize(acc + mult_out(i), psum_intbits, -2*fracbits);
        end loop;
        relu_in <= resize(acc, intbits-1, -fracbits);
    end process;

    activation: entity work.ReLU
        port map(relu_in, result);

end behavior;
