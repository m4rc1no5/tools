<?php

namespace m4rc1no5_tools\Convert\String;


class UnderscoreToCamelcase
{
	/**
	 * Convert underscore string foo_bar to camelcase fooBar
	 *
	 * @param $string
	 * @return mixed
	 */
	public static function underscoreToCamelcase($string)
	{
		return preg_replace('/(?:^|_)(.?)/e', "strtoupper('$1')", $string);
	}
}