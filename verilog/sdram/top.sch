<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="clk" />
        <signal name="XLXN_6" />
        <signal name="XLXN_7" />
        <signal name="XLXN_8(21:0)" />
        <signal name="XLXN_10(15:0)" />
        <signal name="XLXN_11(15:0)" />
        <signal name="led" />
        <signal name="cs_n" />
        <signal name="cas_n" />
        <signal name="ras_n" />
        <signal name="cke" />
        <signal name="we_n" />
        <signal name="ba(1:0)" />
        <signal name="addr(11:0)" />
        <signal name="dqm(1:0)" />
        <signal name="data(15:0)" />
        <signal name="rst" />
        <signal name="sdclk" />
        <signal name="XLXN_28" />
        <port polarity="Input" name="clk" />
        <port polarity="Output" name="led" />
        <port polarity="Output" name="cs_n" />
        <port polarity="Output" name="cas_n" />
        <port polarity="Output" name="ras_n" />
        <port polarity="Output" name="cke" />
        <port polarity="Output" name="we_n" />
        <port polarity="Output" name="ba(1:0)" />
        <port polarity="Output" name="addr(11:0)" />
        <port polarity="Output" name="dqm(1:0)" />
        <port polarity="BiDirectional" name="data(15:0)" />
        <port polarity="Input" name="rst" />
        <port polarity="Output" name="sdclk" />
        <blockdef name="data_ctl">
            <timestamp>2011-9-25T3:32:17</timestamp>
            <rect width="256" x="64" y="-320" height="320" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="sdram_self">
            <timestamp>2011-9-25T3:38:50</timestamp>
            <rect width="352" x="64" y="-960" height="960" />
            <line x2="0" y1="-928" y2="-928" x1="64" />
            <line x2="0" y1="-752" y2="-752" x1="64" />
            <line x2="0" y1="-576" y2="-576" x1="64" />
            <line x2="0" y1="-400" y2="-400" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-60" height="24" />
            <line x2="0" y1="-48" y2="-48" x1="64" />
            <line x2="480" y1="-928" y2="-928" x1="416" />
            <line x2="480" y1="-864" y2="-864" x1="416" />
            <line x2="480" y1="-800" y2="-800" x1="416" />
            <line x2="480" y1="-736" y2="-736" x1="416" />
            <line x2="480" y1="-672" y2="-672" x1="416" />
            <line x2="480" y1="-608" y2="-608" x1="416" />
            <line x2="480" y1="-544" y2="-544" x1="416" />
            <line x2="480" y1="-480" y2="-480" x1="416" />
            <line x2="480" y1="-416" y2="-416" x1="416" />
            <line x2="480" y1="-352" y2="-352" x1="416" />
            <rect width="64" x="416" y="-300" height="24" />
            <line x2="480" y1="-288" y2="-288" x1="416" />
            <rect width="64" x="416" y="-236" height="24" />
            <line x2="480" y1="-224" y2="-224" x1="416" />
            <rect width="64" x="416" y="-172" height="24" />
            <line x2="480" y1="-160" y2="-160" x1="416" />
            <rect width="64" x="416" y="-108" height="24" />
            <line x2="480" y1="-96" y2="-96" x1="416" />
            <rect width="64" x="416" y="-44" height="24" />
            <line x2="480" y1="-32" y2="-32" x1="416" />
        </blockdef>
        <blockdef name="CLK_GEN">
            <timestamp>2011-9-25T4:2:44</timestamp>
            <rect width="336" x="64" y="-256" height="256" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="464" y1="-160" y2="-160" x1="400" />
            <line x2="464" y1="-96" y2="-96" x1="400" />
            <line x2="464" y1="-32" y2="-32" x1="400" />
        </blockdef>
        <block symbolname="sdram_self" name="XLXI_2">
            <blockpin signalname="XLXN_28" name="clk" />
            <blockpin signalname="rst" name="rst" />
            <blockpin signalname="XLXN_6" name="wr_req" />
            <blockpin signalname="XLXN_7" name="rd_req" />
            <blockpin signalname="XLXN_8(21:0)" name="addr(21:0)" />
            <blockpin signalname="XLXN_10(15:0)" name="data_write(15:0)" />
            <blockpin signalname="cs_n" name="cs_n" />
            <blockpin signalname="cas_n" name="cas_n" />
            <blockpin signalname="ras_n" name="ras_n" />
            <blockpin signalname="cke" name="cke" />
            <blockpin signalname="we_n" name="we_n" />
            <blockpin name="wr_ack" />
            <blockpin name="rd_ack" />
            <blockpin name="busy" />
            <blockpin name="wr_done" />
            <blockpin name="rd_done" />
            <blockpin signalname="ba(1:0)" name="ba(1:0)" />
            <blockpin signalname="addr(11:0)" name="add(11:0)" />
            <blockpin signalname="dqm(1:0)" name="dqm(1:0)" />
            <blockpin signalname="XLXN_11(15:0)" name="data_read(15:0)" />
            <blockpin signalname="data(15:0)" name="dq(15:0)" />
        </block>
        <block symbolname="CLK_GEN" name="XLXI_3">
            <blockpin signalname="clk" name="CLKIN_IN" />
            <blockpin name="CLK2X_OUT" />
            <blockpin signalname="sdclk" name="CLKIN_IBUFG_OUT" />
            <blockpin signalname="XLXN_28" name="CLK0_OUT" />
        </block>
        <block symbolname="data_ctl" name="XLXI_1">
            <blockpin signalname="XLXN_28" name="clk" />
            <blockpin signalname="rst" name="rst" />
            <blockpin signalname="XLXN_11(15:0)" name="readdata(15:0)" />
            <blockpin signalname="XLXN_6" name="wr_req" />
            <blockpin signalname="XLXN_7" name="rd_req" />
            <blockpin signalname="led" name="led" />
            <blockpin signalname="XLXN_8(21:0)" name="addr(21:0)" />
            <blockpin signalname="XLXN_10(15:0)" name="data(15:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1792" y="1776" name="XLXI_2" orien="R0">
        </instance>
        <branch name="clk">
            <wire x2="1120" y1="672" y2="672" x1="1088" />
        </branch>
        <iomarker fontsize="28" x="1088" y="672" name="clk" orien="R180" />
        <instance x="1120" y="704" name="XLXI_3" orien="R0">
        </instance>
        <branch name="XLXN_6">
            <wire x2="1520" y1="976" y2="976" x1="1248" />
            <wire x2="1520" y1="976" y2="1200" x1="1520" />
            <wire x2="1792" y1="1200" y2="1200" x1="1520" />
        </branch>
        <branch name="XLXN_7">
            <wire x2="1504" y1="1040" y2="1040" x1="1248" />
            <wire x2="1504" y1="1040" y2="1376" x1="1504" />
            <wire x2="1584" y1="1376" y2="1376" x1="1504" />
            <wire x2="1792" y1="1376" y2="1376" x1="1584" />
        </branch>
        <branch name="XLXN_8(21:0)">
            <wire x2="1488" y1="1168" y2="1168" x1="1248" />
            <wire x2="1488" y1="1168" y2="1552" x1="1488" />
            <wire x2="1792" y1="1552" y2="1552" x1="1488" />
        </branch>
        <branch name="XLXN_10(15:0)">
            <wire x2="1408" y1="1232" y2="1232" x1="1248" />
            <wire x2="1408" y1="1232" y2="1648" x1="1408" />
            <wire x2="1408" y1="1648" y2="1728" x1="1408" />
            <wire x2="1792" y1="1728" y2="1728" x1="1408" />
        </branch>
        <branch name="XLXN_11(15:0)">
            <wire x2="864" y1="1232" y2="1232" x1="752" />
            <wire x2="752" y1="1232" y2="1840" x1="752" />
            <wire x2="2352" y1="1840" y2="1840" x1="752" />
            <wire x2="2352" y1="1680" y2="1680" x1="2272" />
            <wire x2="2352" y1="1680" y2="1840" x1="2352" />
        </branch>
        <branch name="led">
            <wire x2="1280" y1="1104" y2="1104" x1="1248" />
        </branch>
        <iomarker fontsize="28" x="1280" y="1104" name="led" orien="R0" />
        <branch name="cs_n">
            <wire x2="2304" y1="848" y2="848" x1="2272" />
        </branch>
        <iomarker fontsize="28" x="2304" y="848" name="cs_n" orien="R0" />
        <branch name="cas_n">
            <wire x2="2304" y1="912" y2="912" x1="2272" />
        </branch>
        <iomarker fontsize="28" x="2304" y="912" name="cas_n" orien="R0" />
        <branch name="ras_n">
            <wire x2="2304" y1="976" y2="976" x1="2272" />
        </branch>
        <iomarker fontsize="28" x="2304" y="976" name="ras_n" orien="R0" />
        <branch name="cke">
            <wire x2="2304" y1="1040" y2="1040" x1="2272" />
        </branch>
        <iomarker fontsize="28" x="2304" y="1040" name="cke" orien="R0" />
        <branch name="we_n">
            <wire x2="2304" y1="1104" y2="1104" x1="2272" />
        </branch>
        <iomarker fontsize="28" x="2304" y="1104" name="we_n" orien="R0" />
        <branch name="ba(1:0)">
            <wire x2="2304" y1="1488" y2="1488" x1="2272" />
        </branch>
        <iomarker fontsize="28" x="2304" y="1488" name="ba(1:0)" orien="R0" />
        <branch name="addr(11:0)">
            <wire x2="2304" y1="1552" y2="1552" x1="2272" />
        </branch>
        <iomarker fontsize="28" x="2304" y="1552" name="addr(11:0)" orien="R0" />
        <branch name="dqm(1:0)">
            <wire x2="2304" y1="1616" y2="1616" x1="2272" />
        </branch>
        <iomarker fontsize="28" x="2304" y="1616" name="dqm(1:0)" orien="R0" />
        <branch name="data(15:0)">
            <wire x2="2304" y1="1744" y2="1744" x1="2272" />
        </branch>
        <iomarker fontsize="28" x="2304" y="1744" name="data(15:0)" orien="R0" />
        <instance x="864" y="1264" name="XLXI_1" orien="R0">
        </instance>
        <branch name="rst">
            <wire x2="784" y1="1104" y2="1104" x1="560" />
            <wire x2="864" y1="1104" y2="1104" x1="784" />
            <wire x2="784" y1="1104" y2="1344" x1="784" />
            <wire x2="1264" y1="1344" y2="1344" x1="784" />
            <wire x2="1264" y1="1024" y2="1344" x1="1264" />
            <wire x2="1792" y1="1024" y2="1024" x1="1264" />
        </branch>
        <iomarker fontsize="28" x="560" y="1104" name="rst" orien="R180" />
        <branch name="sdclk">
            <wire x2="1616" y1="608" y2="608" x1="1584" />
        </branch>
        <iomarker fontsize="28" x="1616" y="608" name="sdclk" orien="R0" />
        <branch name="XLXN_28">
            <wire x2="864" y1="976" y2="976" x1="800" />
            <wire x2="800" y1="976" y2="1328" x1="800" />
            <wire x2="1760" y1="1328" y2="1328" x1="800" />
            <wire x2="1680" y1="672" y2="672" x1="1584" />
            <wire x2="1680" y1="672" y2="848" x1="1680" />
            <wire x2="1792" y1="848" y2="848" x1="1680" />
            <wire x2="1760" y1="672" y2="672" x1="1680" />
            <wire x2="1760" y1="672" y2="1328" x1="1760" />
        </branch>
    </sheet>
</drawing>