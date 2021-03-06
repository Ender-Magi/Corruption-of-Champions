package classes.Scenes.NPCs
{
	import classes.*;
import classes.StatusEffects.Combat.AnemoneVenomDebuff;
import classes.internals.WeightedDrop;
	import classes.GlobalFlags.kFLAGS;

	public class Anemone extends Monster
	{
		private static const STAT_DOWN_FLAT:int = 4;
		private static const STAT_DOWN_MULT:int = 4;

		override public function eAttack():void
		{
			outputText("Giggling playfully, the anemone launches several tentacles at you.  Most are aimed for your crotch, but a few attempt to caress your chest and face.\n");
			super.eAttack();
		}

		override public function eOneAttack():int
		{
			applyVenom(rand(STAT_DOWN_FLAT + STAT_DOWN_MULT*player.newGamePlusMod() + player.sens / 20) + 1);
			return 1;
		}

		//Apply the effects of AnemoneVenom()
		public function applyVenom(amt:Number = 1):void
		{
			var ave:AnemoneVenomDebuff = player.createOrFindStatusEffect(StatusEffects.AnemoneVenom) as AnemoneVenomDebuff;
			ave.applyEffect(amt);
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.anemoneScene.defeatAnemone();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem to mind at all...");
				doNext(game.endLustLoss);
			} else {
				game.anemoneScene.loseToAnemone();
			}
		}

		override public function outputAttack(damage:int):void
		{
			outputText("You jink and dodge valiantly but the tentacles are too numerous and coming from too many directions.  A few get past your guard and caress your skin, leaving a tingling, warm sensation that arouses you further.");
		}

		public function Anemone()
		{
			this.a = "the ";
			this.short = "anemone";
			this.imageName = "anemone";
			this.long = "The anemone is a blue androgyne humanoid of medium height and slender build, with colorful tentacles sprouting on her head where hair would otherwise be.  Her feminine face contains two eyes of solid color, lighter than her skin.  Two feathery gills sprout from the middle of her chest, along the line of her spine and below her collarbone, and drape over her pair of small B-cup breasts.  Though you wouldn't describe her curves as generous, she sways her girly hips back and forth in a way that contrasts them to her slim waist quite attractively.  Protruding from her groin is a blue shaft with its head flanged by diminutive tentacles, and below that is a dark-blue pussy ringed by small feelers.  Further down are a pair of legs ending in flat sticky feet; proof of her aquatic heritage.  She smiles broadly and innocently as she regards you from her deep eyes.";
			// this.plural = false;
			this.createCock(7,1,CockTypesEnum.ANEMONE);
			this.createVagina(false, VAGINA_WETNESS_SLICK, VAGINA_LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 5, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = ANAL_LOOSENESS_NORMAL;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = 5*12+5;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_NOTICEABLE;
			this.skinTone = "purple";
			this.hairColor = "purplish-black";
			this.hairLength = 20;
			this.hairType = HAIR_ANEMONE;
			initStrTouSpeInte(64, 45, 40, 50);
			initLibSensCor(55, 35, 50);
			this.weaponName = "tendrils";
			this.weaponVerb="tentacle";
			this.weaponAttack = 16 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "clammy skin";
			this.armorDef = 10 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 120;
			this.bonusLust = 20;
			this.lust = 30;
			this.lustVuln = .9;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 12;
			this.gems = rand(20) + 20;
			this.drop = new WeightedDrop(consumables.DRYTENT, 1);
			this.str += 12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 9 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 10 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 11 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 1000;
			checkMonster();
		}
		
	}

}
