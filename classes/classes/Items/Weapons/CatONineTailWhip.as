/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons 
{
	import classes.PerkLib;
	import classes.Player;
	import classes.Items.Weapon;

	public class CatONineTailWhip extends Weapon
	{
		
		public function CatONineTailWhip() 
		{
			super("CNTWhip", "CatONineTailWhip", "Cat o' nine tail whip", "a Cat o' nine tail whip", "whipping", 27, 1080, "A rope made unknown magic beast fur that unravelled into three small ropes, each of which is unravelled again designed to whip and cut your foes into submission.", "Large");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			var base:int = 0;
			base += 5;
			if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 5;
			if ((game.player.str + game.player.spe) >= 270) {
				base += 9;
				if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 9;
			}
			if ((game.player.str + game.player.spe) >= 180) {
				base += 9;
				if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 9;
			}
			if ((game.player.str + game.player.spe) >= 90) {
				base += 4;
				if (game.player.findPerk(PerkLib.ArcaneLash) >= 0) boost += 4;
			}
			return (base + boost);; 
		}
		
		override public function canUse():Boolean {
			if (game.player.findPerk(PerkLib.TitanGrip) >= 0) return true;
			outputText("You aren't skilled in handling large weapons with one hand yet to effectively use this whip. Unless you want to hurt yourself instead enemies when trying to use it...  ");
			return false;
		}
	}
}