/**
 * ...
 * @author Ormael
 */
package classes.Perks 
{
	import classes.PerkClass;
	import classes.PerkType;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class AscensionTranshumanismPerk extends PerkType
	{
		
		override public function desc(params:PerkClass = null):String
		{
			return "(Rank: " + params.value1 + "/" + kGAMECLASS.charCreation.MAX_TRANSHUMANISM_LEVEL + ") Increases maximum Str/Tou/Spe/Int/Lib/Sen by " + params.value1 * 5 + ".";
		}
		
		public function AscensionTranshumanismPerk() 
		{
			super("Ascension: Transhumanism", "Ascension: Transhumanism", "", "Increases maximum Str/Tou/Spe/Int/Lib/Sen by 5.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}
	}

}