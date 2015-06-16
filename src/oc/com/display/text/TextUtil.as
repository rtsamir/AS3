package oc.com.display.text {

	public class TextUtil {

		public static function toCurrency(num:Number, num_div:String = ",", forceDecimals:Boolean = false, dec_div:String = "."):String {

			var spt_num:Array = String(num).split(".");
			spt_num[0] = (spt_num[0] == undefined) ? "0" : spt_num[0];

			if(forceDecimals) {
				spt_num[1] = (spt_num[1]) ? String(dec_div + spt_num[1]).substr(0, 3) : String(dec_div + "00");
			} else {
				spt_num[1] = (spt_num[1]) ? String(dec_div + spt_num[1]).substr(0, 3) : "";
			}
			var result:String = "";

			if(spt_num[0] != "0") {
				var num_arr:Array = String(spt_num[0]).split("");
				num_arr.reverse();
				var pre_num:Array = new Array();
				var i:int = 0;

				for each(var a:String in num_arr) {
					if(i < 3 || a == "-") {
						pre_num.push(a);
					} else {
						pre_num.push(num_div);
						pre_num.push(a);
						i = 0;
					}
					i++
				}
				pre_num.reverse();
				var numero:String = "";

				for each(var b:String in pre_num) {
					numero += b;
				}
				result = numero + spt_num[1];
			} else {
				result = spt_num[0] + spt_num[1];
			}
			return result;
		}

		/**
		 * Static function that gets a number and few conditions and returns a string that represent
		 * that number with those conditions and some mathematical operations.
		 */
		public static function numberFormat(number:*, maxDecimals:uint = 0, minDecimals:uint = 2, siStyle:Boolean = false):String {

			if(Number(number).toString() == Number.NaN.toString()) {
				return "?";
			}

			if(number == 0 && maxDecimals == 0) {
				return "0";
			}

			//			if (number < 1000)
			//				return Number(number).toFixed(maxDecimals);
			if(minDecimals > maxDecimals) {
				minDecimals = maxDecimals;
			}
			var i:int = 0;
			var negative:Boolean = (number < 0);
			var str:String = Math.abs(number).toString();
			var dotPos:int = str.indexOf(".");
			var hasDot:Boolean = (dotPos >= 0);

			if(!hasDot) {
				dotPos = str.length;
			}

			var integer:String = str.substring(0, dotPos);
			var fractional:String = str.substr(dotPos + 1, maxDecimals);

			while(fractional.length < minDecimals) {
				fractional += "0";
			}

			var pos:uint;

			for(var sep_count:int = (integer.length - 1) / 3; sep_count > 0; sep_count--) {
				pos = integer.length - (sep_count * 3);
				integer = integer.substring(0, pos) + (siStyle ? "." : ",") + integer.substr(pos);
			}

			return (negative ? "-" : "") + integer + ((fractional.length) ? ((siStyle ? "," : ".") + fractional) : "");
		}

		public static function literalMannerFormat(number:int, mannerDigitsCount:int, kMannerEnable:Boolean = true):String {

			var result:String;
			mannerDigitsCount = ((mannerDigitsCount > 3) || (mannerDigitsCount < 0)) ? 3 : mannerDigitsCount;

			if(number > Math.exp(Math.log(10) * mannerDigitsCount) * 100000 - 1) {
				number = Math.floor(number / 1000000);
				result = numberFormat(number) + 'M';
			} else if((kMannerEnable) && (number > Math.exp(Math.log(10) * mannerDigitsCount) * 100 - 1)) {
				number = Math.floor(number / 1000);
				result = numberFormat(number) + 'k';
			} else {
				result = numberFormat(number);
			}

			return result;
		}

		// TODO: check negative values
		public static function literalMannerFormatEx(value:Number, conditions:Vector.<NumberFormatCondition>):String {

			var condition:NumberFormatCondition;

			for(var i:int = 0; i < conditions.length; i++) {
				condition = conditions[i];

				if((value >= condition.lowerRangeLimit) && (value <= condition.upperRangeLimit)) {
					break;
				}

				condition = null;
			}

			if(!condition) {
				return value.toString();
			}

			var stringValue:String = String(Math.abs(value) / Math.pow(10, condition.dividerExponent));

			var array:Array = stringValue.split(".");
			var integerSymbols:String = array[0];
			var decimalSymbols:String = (array.length > 1) ? array[1] : "";

			array = integerSymbols.split("");

			for(i = (integerSymbols.length - 1) / 3; i > 0; i--) {
				array.splice(array.length - (3 * i), 0, condition.thousandsSeparator);
			}

			integerSymbols = array.join("");

			while(decimalSymbols.length < condition.minDecimalSymbols) {
				decimalSymbols += "0";
			}

			if(decimalSymbols.search(/[1-9]/) > condition.minDecimalSymbols) {
				decimalSymbols = decimalSymbols.slice(0, condition.minDecimalSymbols);
			} else {
				decimalSymbols = decimalSymbols.slice(0, condition.maxDecimalSymbols);
			}

			if(decimalSymbols.length > 0) {
				decimalSymbols = condition.decimalSeparator + decimalSymbols;
			}

			var result:String = injectUserParamsToString(condition.format, {d:decimalSymbols, i:integerSymbols});

			return (value < 0) ? ("-" + result) : result;
		}

		/**
		 * Static function that gets string and an object with some parameters and returns the string
		 * with the object's fields inside it
		 *
		 */
		public static function injectUserParamsToString(str:String, params:Object):String {

			for(var field:String in params) {
				str = str.replace("[" + field + "]", params[field]);
			}
			return str;
		}

		public static function validateString(input_string:String, reg_exp:RegExp):Boolean {

			var result:Object = reg_exp.exec(input_string);

			if(result == null) {
				return false;
			}
			return true;
		}

		public static function getBooleanByString(value:String):Boolean {

			var lowerCaseValue:String;
			lowerCaseValue = value.toLowerCase();
			return (lowerCaseValue == 'true') || (lowerCaseValue == '1');
		}

		public static function isEmptyString(value:String):Boolean {

			return (value == "") || (value == null);
		}

		public static function trim(value:String):String {

			return value.replace(/^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm, "$2");
		}
	}
}
