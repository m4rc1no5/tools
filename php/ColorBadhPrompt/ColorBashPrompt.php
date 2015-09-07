<?php
/**
 * Created by PhpStorm.
 * User: marcinos
 * Date: 03.07.15
 * Time: 08:32
 */

class ColorBashPrompt {

	const BLACK = 'black';
	const RED = 'red';
	const GREEN = 'green';
	const YELLOW = 'yellow';
	const BLUE = 'blue';
	const PURPLE = 'purple';
	const CYAN = 'cyan';
	const WHITE = 'white';

	const FORMAT_BOLD = 'bld';
	const FORMAT_UNDERLINE = 'und';
	const FORMAT_BACKGROUND = 'bak';

	protected $ar_dostepne_kolory = array(
		self::BLACK,
		self::RED,
		self::GREEN,
		self::YELLOW,
		self::BLUE,
		self::PURPLE,
		self::CYAN,
		self::WHITE,
	);

	protected $ar_dostepne_formaty = array(
		self::FORMAT_BOLD,
		self::FORMAT_UNDERLINE,
		self::FORMAT_BACKGROUND
	);

	protected $black='0;30m'; // Black - Regular
	protected $red='0;31m'; // Red
	protected $green='0;32m'; // Green
	protected $yellow='0;33m'; // Yellow
	protected $blue='0;34m'; // bluee
	protected $purple='0;35m'; // purpleple
	protected $cyan='0;36m'; // Cyan
	protected $white='0;37m'; // White

	protected $bldblack='1;30m'; // Black - Bold
	protected $bldred='1;31m'; // Red
	protected $bldgreen='1;32m'; // Green
	protected $bldyellow='1;33m'; // Yellow
	protected $bldblue='1;34m'; // bluee
	protected $bldpurple='1;35m'; // purpleple
	protected $bldcyan='1;36m'; // Cyan
	protected $bldwhite='1;37m'; // White

	protected $unkblack='4;30m'; // Black - Underline
	protected $undred='4;31m'; // Red
	protected $undgreen='4;32m'; // Green
	protected $undyellow='4;33m'; // Yellow
	protected $undblue='4;34m'; // bluee
	protected $undpurple='4;35m'; // purpleple
	protected $undcyan='4;36m'; // Cyan
	protected $undwhite='4;37m'; // White

	protected $bakblack='40m';   // Black - Background
	protected $bakred='41m';   // Red
	protected $bakgreen='42m';   // Green
	protected $bakyellow='43m';   // Yellow
	protected $bakblue='44m';   // bluee
	protected $bakpurple='45m';   // purpleple
	protected $bakcyan='46m';   // Cyan
	protected $bakwhite='47m';   // White

	protected $txtrst='0m';    // Text Reset

	public function write($text, $color, $format = "", $reset = true)
	{
		//sprawdzamy czy kolor jest w dostepnych kolorach - jesli nie to zwracamy nieprzerobiony string
		if(! in_array($color, $this->ar_dostepne_kolory))
		{
			return $text;
		}

		$pre = "";
		if($format != "")
		{
			if(in_array($format, $this->ar_dostepne_formaty))
			{
				$pre = $format;
			}
		}

		//$text_formatted = "\033[" . $this->{$format . $color} . $text . "\033[37m";
		//echo $format . $color;
		$text_formatted = $this->opakuj($this->{$format . $color} . $text);

		if($reset)
		{
			$text_formatted .= $this->opakuj($this->txtrst);
		}

		return $text_formatted;
	}

	private function opakuj($text)
	{
		return "\033[" . $text . "\033[37m";
	}
}