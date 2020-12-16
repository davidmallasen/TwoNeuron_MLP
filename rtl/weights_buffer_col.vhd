use work.fixed_float_types.all;
use work.fixed_pkg.all;
use work.types_and_constants.all;

entity weights_buffer_col is
    port (
        address     : in integer range 0 to n-1;
        weights_out : out sfixed_array;
        bias_out    : out sfixed_array
    );
end weights_buffer_col;


architecture behavior of weights_buffer_col is

    constant weights : sfixed_mat := (
        (to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits), to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits),
            to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits), to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits)),
        (to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits),
            to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits)),
        (to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits), to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits),
            to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits), to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits)),
        (to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits),
            to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits)),
        (to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits), to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits),
            to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits), to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits)),
        (to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits),
            to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits)),
        (to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits), to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits),
            to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits), to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits)),
        (to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits),
            to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits))
    );

    constant bias : sfixed_array := (
        to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-1.1, intbits-1, -fracbits), to_sfixed(-1.2, intbits-1, -fracbits), to_sfixed(-1.3, intbits-1, -fracbits),
        to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(1.1, intbits-1, -fracbits), to_sfixed(1.2, intbits-1, -fracbits), to_sfixed(1.3, intbits-1, -fracbits) 
    );

begin

    weights_out <= weights(address);
    bias_out <= bias;

end behavior;
