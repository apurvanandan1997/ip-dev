--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:31:01 03/26/2020
-- Design Name:   
-- Module Name:   /home/apurvan/tmp/demod_porj/demod/tb_mod_demod.vhd
-- Project Name:  demod
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: nr_demodulation_v1_0
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_mod_demod IS
END tb_mod_demod;
 
ARCHITECTURE behavior OF tb_mod_demod IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT nr_demodulation_v1_0
    PORT(
         axis_aclk : IN  std_logic;
         axis_aresetn : IN  std_logic;
         s00_axis_tready : OUT  std_logic;
         s00_axis_tdata : IN  std_logic_vector(127 downto 0);
         s00_axis_tstrb : IN  std_logic_vector(15 downto 0);
         s00_axis_tlast : IN  std_logic;
         s00_axis_tvalid : IN  std_logic;
         m00_axis_tvalid : OUT  std_logic;
         m00_axis_tdata : OUT  std_logic_vector(127 downto 0);
         m00_axis_tstrb : OUT  std_logic_vector(15 downto 0);
         m00_axis_tlast : OUT  std_logic;
         m00_axis_tready : IN  std_logic
        );
    END COMPONENT;
    
	 
    COMPONENT nr_modulation_v1_0
    PORT(
         axis_aclk : IN  std_logic;
         axis_aresetn : IN  std_logic;
         s00_axis_tready : OUT  std_logic;
         s00_axis_tdata : IN  std_logic_vector(127 downto 0);
         s00_axis_tstrb : IN  std_logic_vector(15 downto 0);
         s00_axis_tlast : IN  std_logic;
         s00_axis_tvalid : IN  std_logic;
         m00_axis_tvalid : OUT  std_logic;
         m00_axis_tdata : OUT  std_logic_vector(127 downto 0);
         m00_axis_tstrb : OUT  std_logic_vector(15 downto 0);
         m00_axis_tlast : OUT  std_logic;
         m00_axis_tready : IN  std_logic
        );
    END COMPONENT;

   --Inputs
   signal axis_aclk : std_logic := '0';
   signal axis_aresetn : std_logic := '0';
   signal s00_axis_tdata : std_logic_vector(127 downto 0) := (others => '0');
   signal s00_axis_tstrb : std_logic_vector(15 downto 0) := (others => '0');
   signal s00_axis_tlast : std_logic := '0';
   signal s00_axis_tvalid : std_logic := '0';
   signal m00_axis_tready : std_logic := '0';

 	--Outputs
   signal s00_axis_tready : std_logic;
   signal m00_axis_tvalid : std_logic;
   signal m00_axis_tdata : std_logic_vector(127 downto 0);
   signal m00_axis_tstrb : std_logic_vector(15 downto 0);
   signal m00_axis_tlast : std_logic;
	
	signal m01_axis_tvalid : std_logic;
   signal m01_axis_tdata : std_logic_vector(127 downto 0);
   signal m01_axis_tstrb : std_logic_vector(15 downto 0);
   signal m01_axis_tlast : std_logic;

   -- Clock period definitions
   constant axis_aclk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: nr_modulation_v1_0 PORT MAP (
          axis_aclk => axis_aclk,
          axis_aresetn => axis_aresetn,
          s00_axis_tready => s00_axis_tready,
          s00_axis_tdata => s00_axis_tdata,
          s00_axis_tstrb => s00_axis_tstrb,
          s00_axis_tlast => s00_axis_tlast,
          s00_axis_tvalid => s00_axis_tvalid,
          m00_axis_tvalid => m00_axis_tvalid,
          m00_axis_tdata => m00_axis_tdata,
          m00_axis_tstrb => m00_axis_tstrb,
          m00_axis_tlast => m00_axis_tlast,
          m00_axis_tready => m00_axis_tready
        );
	
   uut2: nr_demodulation_v1_0 PORT MAP (
          axis_aclk => axis_aclk,
          axis_aresetn => axis_aresetn,
          s00_axis_tready => m00_axis_tready,
          s00_axis_tdata => m00_axis_tdata,
          s00_axis_tstrb => m00_axis_tstrb,
          s00_axis_tlast => m00_axis_tlast,
          s00_axis_tvalid => m00_axis_tvalid,
          m00_axis_tvalid => m01_axis_tvalid,
          m00_axis_tdata => m01_axis_tdata,
          m00_axis_tstrb => m01_axis_tstrb,
          m00_axis_tlast => m01_axis_tlast,
          m00_axis_tready => '1'
        );

   -- Clock process definitions
   axis_aclk_process :process
   begin
		axis_aclk <= '0';
		wait for axis_aclk_period/2;
		axis_aclk <= '1';
		wait for axis_aclk_period/2;
   end process;
 
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      axis_aresetn <= '1';
      wait for 5 ns;
      s00_axis_tvalid <= '1';
      wait for 1120 ns;
      s00_axis_tlast <= '1';
      wait for 160 ns;
      s00_axis_tlast <= '0';
      s00_axis_tvalid <= '0';
			 
      --s00_axis_tready <= '0';
      --wait for axis_aclk_period*20;
      --s00_axis_tready <= '1';
      
      --s00_axis_tvalid <= '1';
      --s00_axis_tdata <= x"00010001000100010001000100010001";
      --wait for axis_aclk_period;
      --wait until s00_axis_tready = '1';
      --s00_axis_tvalid <= '1';
      --s00_axis_tdata <= x"00020002000200020002000200020002";
      --wait for axis_aclk_period;
      --wait until s00_axis_tready = '1';
      --s00_axis_tvalid <= '1';
      --s00_axis_tdata <= x"00030003000300030003000300030003";
      --wait for axis_aclk_period;
      --wait until s00_axis_tready = '1';
      --s00_axis_tvalid <= '1';
      --s00_axis_tdata <= x"00010001000100010001000100010001";
      --wait for axis_aclk_period;
      --wait until s00_axis_tready = '1';
      -- insert stimulus here 

      wait;
   end process;
   process(axis_aclk)
  begin
    if rising_edge(axis_aclk) then
      if axis_aresetn = '0' then
        s00_axis_tdata <= x"00000000000000000000000000000000";

      else
          if s00_axis_tready = '1' and s00_axis_tvalid = '1' then
          s00_axis_tdata <= (s00_axis_tdata(125 downto 0) & "10") xor x"662A332A662A332A662A332A662A332A";
			elsif s00_axis_tvalid = '0' then
				s00_axis_tdata <= x"00000000000000000000000000000000";

        end if;
      end if;
    end if;
  end process;


END;
