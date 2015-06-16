package oc.com.display.text {


	public class NumberFormatCondition {
		public var lowerRangeLimit:Number;
		public var upperRangeLimit:Number;
		public var dividerExponent:uint;
		public var maxDecimalSymbols:uint;
		public var minDecimalSymbols:uint;
		public var thousandsSeparator:String;
		public var decimalSeparator:String;
		public var format:String;

		public function NumberFormatCondition(format:String = null,
			lowerRangeLimit:Number = Number.NEGATIVE_INFINITY,
			upperRangeLimit:Number = Number.POSITIVE_INFINITY,
			dividerExponent:uint = 0,
			maxDecimalSymbols:uint = 20,
			minDecimalSymbols:uint = 0,
			thousandsSeparator:String = ",",
			decimalSeparator:String = ".") {

			if(upperRangeLimit < lowerRangeLimit) {
				throw new ArgumentError("upperRangeLimit is less then lowerRangeLimit");
			}

			if(maxDecimalSymbols < minDecimalSymbols) {
				throw new ArgumentError("maxDecimalSymbols is less then minDecimalSymbols");
			}

			if(format == null) {
				format = "[i][d]";
			}

			this.lowerRangeLimit = lowerRangeLimit;
			this.upperRangeLimit = upperRangeLimit;
			this.dividerExponent = dividerExponent;
			this.maxDecimalSymbols = maxDecimalSymbols;
			this.minDecimalSymbols = minDecimalSymbols;
			this.thousandsSeparator = thousandsSeparator;
			this.decimalSeparator = decimalSeparator;
			this.format = format;
		}
	}
}
