library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nr_modulation_v1_0 is
	port (
		axis_aclk	: in std_logic;
		axis_aresetn	: in std_logic;

		-- Ports of Axi Slave Bus Interface S00_AXIS
		s00_axis_tready	: out std_logic;
		s00_axis_tdata	: in std_logic_vector(127 downto 0);
		s00_axis_tstrb	: in std_logic_vector(15 downto 0);
		s00_axis_tlast	: in std_logic;
		s00_axis_tvalid	: in std_logic;

		-- Ports of Axi Master Bus Interface M00_AXIS
		--m00_axis_aclk	: in std_logic;
		--m00_axis_aresetn	: in std_logic;
		m00_axis_tvalid	: out std_logic;
		m00_axis_tdata	: out std_logic_vector(127 downto 0);
		m00_axis_tstrb	: out std_logic_vector(15 downto 0);
		m00_axis_tlast	: out std_logic;
		m00_axis_tready	: in std_logic
	);
end nr_modulation_v1_0;

architecture arch_imp of nr_modulation_v1_0 is

--    (to_signed(16#2d41#, 16), to_signed(-16#2d41#, 16));
begin
	s00_axis_tready <= m00_axis_tready;
	m00_axis_tstrb <= (others => '1');

	process(axis_aclk)
	begin
		if rising_edge(axis_aclk) then
			if s00_axis_tvalid = '1' then
				case  is
					when <choice_1> =>
						
					when others =>
						null;
				end case;

			else
				s00_axis_tdata <= s00_axis_tdata;
			end if;
		end if;
	end process;


end arch_imp;
