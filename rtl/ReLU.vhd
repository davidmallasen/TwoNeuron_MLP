use work.fixed_float_types.all;
use work.fixed_pkg.all;
use work.types_and_constants.all;

entity ReLU is
    port (
        relu_in     : in sfixed(intbits-1 downto -fracbits);
        relu_out    : out sfixed(intbits-1 downto -fracbits)
    );
end ReLU;


architecture behavior of ReLU is
begin

    relu_out <= relu_in when relu_in > 0 else to_sfixed(0, intbits-1, -fracbits);

end behavior;
