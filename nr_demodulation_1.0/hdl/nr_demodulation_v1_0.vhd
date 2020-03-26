library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity nr_demodulation_v1_0 is
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
end nr_demodulation_v1_0;

architecture arch_imp of nr_demodulation_v1_0 is
	signal counter : std_logic_vector(3 downto 0) := (others => '0');
	signal index : integer;
	signal dibits : std_logic_vector(7 downto 0);
	signal m00_axis_tvalid_int : std_logic;
	signal s00_axis_tvalid_int : std_logic;
	signal s00_axis_tlast_int : std_logic;
	signal m00_axis_tdata_buf : std_logic_vector(127 downto 0);
	
begin
	m00_axis_tvalid_int <= not(counter(0) or counter(1) or counter(2) or counter(3)) and s00_axis_tvalid_int;
	m00_axis_tvalid <= m00_axis_tvalid_int;
	m00_axis_tstrb <= (others => '1');
	s00_axis_tvalid_int <= s00_axis_tvalid when rising_edge(axis_aclk);
	s00_axis_tlast_int <= s00_axis_tlast when rising_edge(axis_aclk);
	s00_axis_tready <= m00_axis_tready;
	m00_axis_tlast <= s00_axis_tlast_int and not(counter(0) or counter(1) or counter(2) or counter(3)) and s00_axis_tvalid_int;
	index <= to_integer(unsigned(counter(3 downto 0)));
	m00_axis_tdata_buf((index + 1)*8-1 downto index*8) <= dibits;


	GEN_ROM: for I in 0 to 3 generate
		with s00_axis_tdata((I+1)*32-1 downto I*32) select dibits((I+1)*2-1 downto I*2) <=
			"00" when x"2D412D41",
			"01" when x"2D41D2BF",
			"10" when x"D2BF2D41",
			"11" when x"D2BFD2BF",
			"00" when others;

    end generate GEN_ROM;

process(axis_aclk)
	begin
		if rising_edge(axis_aclk) then
			if axis_aresetn = '0' then
				counter <= (others => '0');
				m00_axis_tdata <= (others => '0');

			else
				if s00_axis_tvalid = '1' then
					counter <= counter + '1';
				else
					counter <= (others => '0');

				end if;

				if counter = "1111" then
					m00_axis_tdata <= m00_axis_tdata_buf;

				end if;
			end if;
		end if;
	end process;

end arch_imp;
