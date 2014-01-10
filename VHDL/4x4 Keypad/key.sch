<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1" />
        <signal name="XLXN_2" />
        <signal name="XLXN_3" />
        <signal name="XLXN_10(3:0)" />
        <signal name="COL(3:0)" />
        <signal name="ROW(3:0)" />
        <signal name="LED(7:0)" />
        <signal name="DIGIT(2:0)" />
        <signal name="GCLKP1" />
        <signal name="RESET" />
        <port polarity="Output" name="COL(3:0)" />
        <port polarity="Input" name="ROW(3:0)" />
        <port polarity="Output" name="LED(7:0)" />
        <port polarity="Output" name="DIGIT(2:0)" />
        <port polarity="Input" name="GCLKP1" />
        <port polarity="Input" name="RESET" />
        <blockdef name="Frequency">
            <timestamp>2012-10-17T5:49:29</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="LED8">
            <timestamp>2012-10-17T5:49:19</timestamp>
            <rect width="288" x="64" y="-640" height="640" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <rect width="64" x="0" y="-492" height="24" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <rect width="64" x="0" y="-364" height="24" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="352" y="-620" height="24" />
            <line x2="416" y1="-608" y2="-608" x1="352" />
            <rect width="64" x="352" y="-332" height="24" />
            <line x2="416" y1="-320" y2="-320" x1="352" />
            <rect width="64" x="352" y="-44" height="24" />
            <line x2="416" y1="-32" y2="-32" x1="352" />
        </blockdef>
        <blockdef name="key44">
            <timestamp>2012-10-17T5:49:12</timestamp>
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="0" y1="96" y2="96" x1="64" />
            <line x2="384" y1="32" y2="32" x1="320" />
            <rect width="64" x="320" y="84" height="24" />
            <line x2="384" y1="96" y2="96" x1="320" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <rect width="256" x="64" y="-192" height="320" />
        </blockdef>
        <block symbolname="Frequency" name="XLXI_1">
            <blockpin signalname="RESET" name="RESET" />
            <blockpin signalname="GCLKP1" name="GCLKP1" />
            <blockpin signalname="XLXN_1" name="ClockScan" />
            <blockpin signalname="XLXN_2" name="KeyScan" />
        </block>
        <block symbolname="LED8" name="XLXI_2">
            <blockpin signalname="RESET" name="RESET" />
            <blockpin signalname="XLXN_1" name="ClockScan" />
            <blockpin signalname="XLXN_10(3:0)" name="LED1(3:0)" />
            <blockpin signalname="XLXN_10(3:0)" name="LED2(3:0)" />
            <blockpin signalname="XLXN_10(3:0)" name="LED3(3:0)" />
            <blockpin signalname="XLXN_10(3:0)" name="LED4(3:0)" />
            <blockpin signalname="XLXN_10(3:0)" name="LED5(3:0)" />
            <blockpin signalname="XLXN_10(3:0)" name="LED6(3:0)" />
            <blockpin signalname="XLXN_10(3:0)" name="LED7(3:0)" />
            <blockpin signalname="XLXN_10(3:0)" name="LED8(3:0)" />
            <blockpin name="light(7:0)" />
            <blockpin signalname="LED(7:0)" name="LEDOut(7:0)" />
            <blockpin signalname="DIGIT(2:0)" name="DigitSelect(2:0)" />
        </block>
        <block symbolname="key44" name="XLXI_3">
            <blockpin signalname="XLXN_2" name="sys_clk" />
            <blockpin signalname="RESET" name="rst" />
            <blockpin signalname="ROW(3:0)" name="row(3:0)" />
            <blockpin name="valid" />
            <blockpin signalname="XLXN_10(3:0)" name="code(3:0)" />
            <blockpin signalname="COL(3:0)" name="col(3:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="2000" y="1728" name="XLXI_2" orien="R0">
        </instance>
        <instance x="1200" y="1040" name="XLXI_1" orien="R0">
        </instance>
        <instance x="1152" y="1728" name="XLXI_3" orien="R0">
        </instance>
        <branch name="XLXN_1">
            <wire x2="1792" y1="944" y2="944" x1="1584" />
            <wire x2="1792" y1="944" y2="1184" x1="1792" />
            <wire x2="2000" y1="1184" y2="1184" x1="1792" />
        </branch>
        <branch name="XLXN_2">
            <wire x2="1152" y1="1760" y2="1760" x1="1088" />
            <wire x2="1088" y1="1760" y2="1920" x1="1088" />
            <wire x2="1664" y1="1920" y2="1920" x1="1088" />
            <wire x2="1664" y1="1008" y2="1008" x1="1584" />
            <wire x2="1664" y1="1008" y2="1920" x1="1664" />
        </branch>
        <branch name="XLXN_10(3:0)">
            <wire x2="1984" y1="1824" y2="1824" x1="1536" />
            <wire x2="2000" y1="1248" y2="1248" x1="1984" />
            <wire x2="1984" y1="1248" y2="1312" x1="1984" />
            <wire x2="2000" y1="1312" y2="1312" x1="1984" />
            <wire x2="1984" y1="1312" y2="1376" x1="1984" />
            <wire x2="2000" y1="1376" y2="1376" x1="1984" />
            <wire x2="1984" y1="1376" y2="1440" x1="1984" />
            <wire x2="2000" y1="1440" y2="1440" x1="1984" />
            <wire x2="1984" y1="1440" y2="1504" x1="1984" />
            <wire x2="2000" y1="1504" y2="1504" x1="1984" />
            <wire x2="1984" y1="1504" y2="1568" x1="1984" />
            <wire x2="2000" y1="1568" y2="1568" x1="1984" />
            <wire x2="1984" y1="1568" y2="1632" x1="1984" />
            <wire x2="2000" y1="1632" y2="1632" x1="1984" />
            <wire x2="1984" y1="1632" y2="1696" x1="1984" />
            <wire x2="2000" y1="1696" y2="1696" x1="1984" />
            <wire x2="1984" y1="1696" y2="1824" x1="1984" />
        </branch>
        <branch name="COL(3:0)">
            <wire x2="1600" y1="1472" y2="1472" x1="976" />
            <wire x2="1600" y1="1472" y2="1568" x1="1600" />
            <wire x2="1600" y1="1568" y2="1568" x1="1536" />
        </branch>
        <branch name="ROW(3:0)">
            <wire x2="1152" y1="1696" y2="1696" x1="976" />
        </branch>
        <branch name="LED(7:0)">
            <wire x2="2592" y1="1408" y2="1408" x1="2416" />
        </branch>
        <branch name="DIGIT(2:0)">
            <wire x2="2656" y1="1696" y2="1696" x1="2416" />
        </branch>
        <branch name="GCLKP1">
            <wire x2="1200" y1="1008" y2="1008" x1="1168" />
        </branch>
        <iomarker fontsize="28" x="1168" y="1008" name="GCLKP1" orien="R180" />
        <branch name="RESET">
            <wire x2="1120" y1="944" y2="944" x1="976" />
            <wire x2="1184" y1="944" y2="944" x1="1120" />
            <wire x2="1200" y1="944" y2="944" x1="1184" />
            <wire x2="1120" y1="928" y2="928" x1="992" />
            <wire x2="1120" y1="928" y2="944" x1="1120" />
            <wire x2="992" y1="928" y2="1072" x1="992" />
            <wire x2="1136" y1="1072" y2="1072" x1="992" />
            <wire x2="1136" y1="1072" y2="1120" x1="1136" />
            <wire x2="2000" y1="1120" y2="1120" x1="1136" />
            <wire x2="1136" y1="1120" y2="1712" x1="1136" />
            <wire x2="1136" y1="1712" y2="1824" x1="1136" />
            <wire x2="1152" y1="1824" y2="1824" x1="1136" />
        </branch>
        <iomarker fontsize="28" x="976" y="1472" name="COL(3:0)" orien="R180" />
        <iomarker fontsize="28" x="976" y="1696" name="ROW(3:0)" orien="R180" />
        <iomarker fontsize="28" x="2656" y="1696" name="DIGIT(2:0)" orien="R0" />
        <iomarker fontsize="28" x="2592" y="1408" name="LED(7:0)" orien="R0" />
        <iomarker fontsize="28" x="976" y="944" name="RESET" orien="R180" />
    </sheet>
</drawing>