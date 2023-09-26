<?
/*********************************************/
/* Created by lcc, 2002/1/22                 */
/* PHP counter                               */
/* from somebody's source code               */
/*********************************************/

function LoadPNG ($imgname) {
    $im = @ImageCreateFromPNG ($imgname); /* Attempt to open */
    if (!$im) { /* See if it failed */
        $im  = ImageCreate (150, 30); /* Create a blank image */
        $bgc = ImageColorAllocate ($im, 255, 255, 255);
        $tc  = ImageColorAllocate ($im, 0, 0, 0);
        ImageFilledRectangle ($im, 0, 0, 150, 30, $bgc);
        /* Output an errmsg */
        ImageString ($im, 1, 5, 5, "Error loading $imgname", $tc);
    }
    return $im;
}

$digitpath = "digits/";
$datapath = "visit_log/";
$filename = date("Ymd").".txt";

if (!file_exists($datapath."last.txt")) {
	$fp_last = fopen($datapath."last.txt","w");
	fwrite($fp_last,"1");
	$counter = 1;
} else {
	$fp_last = fopen($datapath."last.txt","w");
	$counter = fread($fp_last,6);
}

if (!file_exists($datapath.$filename)) {
	$fp = fopen($datapath.$filename,"w"); 
	//fwrite($fp,"000001"); //这里假设最大为6位，可以根据需要修改 
	//$counter = "000001"; 
	fclose($fp);
} else { //检查counter.txt文件是否存在，如果不存在则新建一个文件，并且写入“00001”。
	$fp = fopen($datapath.$filename,"r+w");
	fseek($fp,-43,SEEK_END);
	$s = fgets($fp,43); //取最近一次记录
	fclose($fp);
	$rec = explode(';',$s);
	$ip_pre = trim($rec[0]);
	$time_pre = $rec[1];
	$counter = $rec[2];
	$ip = getenv("REMOTE_ADDR");
	$time = date("Y-m-d H:i:s");
	if ($ip != $ip_pre && substr($ip,0,9) != "172.16.46") { //如果是同一个ip访问或内网ip，不进行累计
		$counter += 1;
		fwrite($fp_last,$counter);
		switch (strlen($counter)) { //将counter变量格式化，这样显得美观 
			case 1:
				$counter = "00000".$counter;
				break;
			case 2:
				$counter = "0000".$counter;
				break;
			case 3:
				$counter = "000".$counter;
				break;
			case 4:
				$counter = "00".$counter;
				break;
			case 5:
				$counter = "0".$counter;
				break;
		}
		$fp = fopen($datapath.$filename,"r+w");
		fseek($fp,0,SEEK_END);
		fwrite($fp,str_pad($ip,15).";".$time.";".$counter."\n");
		fclose($fp);
	}
}

fclose($fp_last);

Header("Content-type: image/png");
if ($dd == "") {
	$dd = "A";
}
$NumPic = LoadPNG($digitpath.$dd."/strip.png");

$NumPicX = ImageSX($NumPic);
$num_w = $NumPicX / 14;
$NumPicY = ImageSY($NumPic);
$num_h = $NumPicY;
$pic = ImageCreate($num_w * 6 + 1,$num_h); //创建图像

//$pic = ImageCreate(50,17); //创建图像
//$bkcolor = ImageColorAllocate($pic,0,0,0); //定义背景色
//$fcolor = ImageColorAllocate($pic,0,255,0); //定义字体颜色
//ImageLine($pic,0,0,50,17,$bkcolor);
//ImageString($pic,3,1,1,$counter,$fcolor);
if ($tr == "T") {
	$transcolor = ImageColorAt($NumPic,0,0);
	ImageColorAllocate($pic,0,0,0);
	ImageColorTransparent($pic);
}
for ($i = 0; $i < 6; $i ++) {
	$num = intval(substr($counter,$i,1));
	ImageCopy($pic,$NumPic,$i * $num_w,0,$num * $num_w,0,$num_w + 1,$num_h);
}
ImagePng($pic);
ImageDestroy($pic);
?> 
