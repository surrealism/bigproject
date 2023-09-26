<html>
<head>
<title>访问统计</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="../normal.css">
<script language="JavaScript" src="../chk.js"></script>
<script language="JavaScript">
<!--
function datacheck(dataform) {

	if (dataform.KSSJ.value == "") {
		alert("请输入开始时间！");
		dataform.KSSJ.focus();
		return false;
	}
	if (dataform.JSSJ.value == "") {
		alert("请输入结束时间！");
		dataform.JSSJ.focus();
		return false;
	}
	var space11 = "           ";
	if (dataform.KSSJ.value.length <= 11) {
		dataform.KSSJ.value = (dataform.KSSJ.value + space11).substring(0,11) + "00:00:00";
	}
	if (dataform.KSSJ.value.length <= 16) {
		dataform.KSSJ.value = (dataform.KSSJ.value + space11).substring(0,16) + ":00";
	}
	if (dataform.JSSJ.value.length <= 11) {
		dataform.JSSJ.value = (dataform.JSSJ.value + space11).substring(0,11) + "00:00:00";
	}
	if (dataform.JSSJ.value.length <= 16) {
		dataform.JSSJ.value = (dataform.JSSJ.value + space11).substring(0,16) + ":00";
	}

	if (!checkD(dataform.KSSJ.value.substring(0,10)) || !checkT(dataform.KSSJ.value.substring(11,22))) {
		alert("请输入正确的开始时间！");
		dataform.KSSJ.focus();
		return false;
	}
	if (!checkD(dataform.JSSJ.value.substring(0,10)) || !checkT(dataform.JSSJ.value.substring(11,22))) {
		alert("请输入正确的结束时间！");
		dataform.JSSJ.focus();
		return false;
	}
	else return true;
}
//-->
</script>
</head>

<body>
<p align="center" class="f5">访问统计</p>
<?
$datapath = "visit_log/";

if ($KSSJ != "" && $JSSJ != "") {
	$KS_y = intval(substr($KSSJ,0,4));
	$KS_m = intval(substr($KSSJ,5,7));
	$KS_d = intval(substr($KSSJ,8,10));
	$KS_h = intval(substr($KSSJ,11,13));
	$KS_mi = intval(substr($KSSJ,14,16));
	$KS_s = intval(substr($KSSJ,17,19));
	$KS_ap = strtoupper(substr($KSSJ,20,22));
	$begintime = mktime($KS_h,$KS_mi,$KS_s,$KS_m,$KS_d,$KS_y);
	$JS_y = intval(substr($JSSJ,0,4));
	$JS_m = intval(substr($JSSJ,5,7));
	$JS_d = intval(substr($JSSJ,8,10));
	$JS_h = intval(substr($JSSJ,11,13));
	$JS_mi = intval(substr($JSSJ,14,16));
	$JS_s = intval(substr($JSSJ,17,19));
	$JS_ap = strtoupper(substr($JSSJ,20,22));
	$endtime = mktime($JS_h,$JS_mi,$JS_s,$JS_m,$JS_d,$JS_y);

	$duration = $endtime - $begintime;

	$filedate = date("Ymd",$begintime);
	$enddate = date("Ymd",$endtime);
	$FWJL = "";
	$count = 0;
	$days = 0;
	while ($filedate <= $enddate) {
		$filename = $filedate.".txt";
		if (file_exists($datapath.$filename)) {
			$fp = fopen($datapath.$filename,"r");
			while ($s = fgets($fp,45)) {
				$rec = explode(';',str_replace("\n","",$s));
				$ip = $rec[0];
				$visittime = $rec[1];
				$visitno = $rec[2];
				$FWJL .= (str_pad($ip,16)." | ".$visittime." | ".$visitno."\n");
				$vi_y = intval(substr($visittime,0,4));
				$vi_m = intval(substr($visittime,5,7));
				$vi_d = intval(substr($visittime,8,10));
				$vi_h = intval(substr($visittime,11,13));
				$vi_mi = intval(substr($visittime,14,16));
				$vi_s = intval(substr($visittime,17,19));
				$vi_ap = strtoupper(substr($visittime,20,22));
				if ($vi_ap == "PM" && $vi_h < 12) {
					$vi_h += 12;
				}
				$countnum = $rec[2];
				$visittime1 = mktime($vi_h,$vi_mi,$vi_s,$vi_m,$vi_d,$vi_y);
				if (($visittime1 >= $begintime && $visittime1 <= $endtime) && $countnum != "") $count ++;
			}
			fclose($fp);
		}
		$days ++;
		$filedate = date("Ymd",mktime($KS_h,$KS_mi,0,$KS_m,$KS_d + $days,$KS_y));
	}

	if ($duration > 0) {
		$countbyhour = $count / ($duration / 60 / 60);
		$duration_sec = $duration / $count;
	}
}
?>
<form name="lb" method="post" action="<?echo basename($PHP_SELF);?>" onSubmit="return datacheck(this);">
<input type="hidden" name="flag" value="1">
<table width=100% border=1 cellpadding=1 cellspacing=0 bordercolordark=#ffffff bordercolorlight=#000000>
<tr>
	<td class="cell3" width="14%">开始时间</td>
	<td class="cell5" width="36%"><input type="text" name="KSSJ" size="22" maxlength="22" value="<?echo $KSSJ;?>"></td>
	<td class="cell3" width="14%">结束时间</td>
	<td class="cell5"><input type="text" name="JSSJ" size="22" maxlength="22" value="<?echo $JSSJ;?>"></td>
</tr>
</table>
<table width=100% border=1 cellpadding=1 cellspacing=0 bordercolordark=#ffffff bordercolorlight=#000000>
<tr>
	<td class="cell3" width="14%">访问次数</td>
	<td class="cell5" width="36%"><?echo $count;?>次</td>
	<td class="cell3" width="14%">访问频率</td>
	<td class="cell5"><?echo number_format($countbyhour,3);?>次/小时（间隔 <?echo number_format($duration_sec,2);?>秒）</td>
</tr>
</table>
<table width=100% border=1 cellpadding=1 cellspacing=0 bordercolordark=#ffffff bordercolorlight=#000000>
<tr>
	<td class="cell3" width="14%">访问记录</td>
	<td class="cell5" colspan="3">
	<table width="500">
	<tr>
	<td width="120">IP地址</td><td width="150">访问时间</td><td>计数</td>
	</tr>
	</table>
	<textarea name="FWJL" rows="10" cols="70"><?echo $FWJL;?></textarea></td>
</tr>
</table>
<p align="center">
<input type="submit" value="统计">
<input type="reset" value="重置">
</p>
</form>

</body>
</html>
