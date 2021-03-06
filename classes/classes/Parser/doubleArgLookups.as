﻿
		// provides rubiLookups and arianLookups
		// note that these are only used in doubleArgLookups, not in Parser.as itself
		//
		// =!= NOTE: MUST BE IMPORTED BEFORE "./doubleArgLookups.as" =!=
		// 
		//Calls are now made through kGAMECLASS rather than thisPtr. This allows the compiler to detect if/when a function is inaccessible.
		import classes.BodyParts.Skin;
		import classes.GlobalFlags.kGAMECLASS;
		include "./npcLookups.as";


		// PC ASCII Aspect lookups

		public var cockLookups:Object = // For subject: "cock"
		{
			"all"		: function(thisPtr:*):*{ return kGAMECLASS.player.multiCockDescriptLight(); },
			"each"		: function(thisPtr:*):*{ return kGAMECLASS.player.sMultiCockDesc(); },
			"one"		: function(thisPtr:*):*{ return kGAMECLASS.player.oMultiCockDesc(); },
			"largest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.biggestCockIndex()); },
			"biggest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.biggestCockIndex()); },
			"biggest2"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.biggestCockIndex2()); },
			"biggest3"  : function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.biggestCockIndex3()); },
			"smallest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.smallestCockIndex()); },
			"smallest2" : function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.smallestCockIndex2()); },
			"longest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.longestCock()); },
			"shortest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockDescript(kGAMECLASS.player.shortestCockIndex()); }
		}


		public var cockHeadLookups:Object = // For subject: "cockHead"
		{
			"biggest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.biggestCockIndex()); },
			"biggest2"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.biggestCockIndex2()); },
			"biggest3"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.biggestCockIndex3()); },
			"largest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.biggestCockIndex()); },
			"smallest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.smallestCockIndex()); },
			"smallest2"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.smallestCockIndex2()); },
			"longest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.longestCock()); },			// the *head* of a cock has a length? Wut?
			"shortest"	: function(thisPtr:*):*{ return kGAMECLASS.player.cockHead(kGAMECLASS.player.shortestCockIndex()); }
		}

		public var monsterLookups:Object = {
			"a"							: function(thisPtr:*):* { return kGAMECLASS.monster.a; },
			"allbreasts"				: function(thisPtr:*):* { return kGAMECLASS.monster.allBreastsDescript(); },
			"alltits"				    : function(thisPtr:*):* { return kGAMECLASS.monster.allBreastsDescript(); },
			"armor"						: function(thisPtr:*):* { return kGAMECLASS.monster.armorName;},
			"armorname"					: function(thisPtr:*):* { return kGAMECLASS.monster.armorName;},
			"ass"						: function(thisPtr:*):* { return kGAMECLASS.monster.buttDescript();},
			"asshole"					: function(thisPtr:*):* { return kGAMECLASS.monster.assholeDescript(); },
			"balls"						: function(thisPtr:*):* { return kGAMECLASS.monster.ballsDescriptLight(); },
//			"bodytype"					: function(thisPtr:*):* { return kGAMECLASS.monster.bodyType(); },
			"boyfriend"					: function(thisPtr:*):* { return kGAMECLASS.monster.mf("boyfriend", "girlfriend"); },
			"breasts"					: function(thisPtr:*):* { return kGAMECLASS.monster.breastDescript(0); },
			"butt"						: function(thisPtr:*):* { return kGAMECLASS.monster.buttDescript();},
			"butthole"					: function(thisPtr:*):* { return kGAMECLASS.monster.assholeDescript();},
			"chest"						: function(thisPtr:*):* { return kGAMECLASS.monster.chestDesc(); },
			"claws"						: function(thisPtr:*):* { return kGAMECLASS.monster.claws(); },
			"clit"						: function(thisPtr:*):* { return kGAMECLASS.monster.clitDescript(); },
			"cock"						: function(thisPtr:*):* { return kGAMECLASS.monster.cockDescript(0);},
			"cockhead"					: function(thisPtr:*):* { return kGAMECLASS.monster.cockHead(0);},
			"cocks"						: function(thisPtr:*):* { return kGAMECLASS.monster.multiCockDescriptLight(); },
			"cunt"						: function(thisPtr:*):* { return kGAMECLASS.monster.vaginaDescript(); },
			"eachcock"					: function(thisPtr:*):* { return kGAMECLASS.monster.sMultiCockDesc();},
			"eyes"						: function(thisPtr:*):* { return kGAMECLASS.monster.eyesDescript();},
			"eyecolor"					: function(thisPtr:*):* { return kGAMECLASS.monster.eyeColor;},
//			"face"						: function(thisPtr:*):* { return kGAMECLASS.monster.face(); },
			"feet"						: function(thisPtr:*):* { return kGAMECLASS.monster.feet(); },
			"foot"						: function(thisPtr:*):* { return kGAMECLASS.monster.foot(); },
			"fullchest"					: function(thisPtr:*):* { return kGAMECLASS.monster.allChestDesc(); },
			"hair"						: function(thisPtr:*):* { return kGAMECLASS.monster.hairDescript(); },
			"haircolor"					: function(thisPtr:*):* { return kGAMECLASS.monster.hairColor; },
			"hairorfur"					: function(thisPtr:*):* { return kGAMECLASS.monster.hairOrFur(); },
			"he"						: function(thisPtr:*):* { return kGAMECLASS.monster.pronoun1; },
			"him"						: function(thisPtr:*):* { return kGAMECLASS.monster.pronoun2; },
			"himher"					: function(thisPtr:*):* { return kGAMECLASS.monster.pronoun2; },
			"himself"					: function(thisPtr:*):* { return kGAMECLASS.monster.mf("himself", "herself"); },
			"herself"					: function(thisPtr:*):* { return kGAMECLASS.monster.mf("himself", "herself"); },
			"hips"						: function(thisPtr:*):* { return kGAMECLASS.monster.hipDescript();},
			"his"						: function(thisPtr:*):* { return kGAMECLASS.monster.pronoun3; },
			"hisher"					: function(thisPtr:*):* { return kGAMECLASS.monster.pronoun3; },
			"horns"						: function(thisPtr:*):* { return kGAMECLASS.monster.hornDescript(); },
			"leg"						: function(thisPtr:*):* { return kGAMECLASS.monster.leg(); },
			"legs"						: function(thisPtr:*):* { return kGAMECLASS.monster.legs(); },
			"lowergarment"				: function(thisPtr:*):* { return kGAMECLASS.monster.lowerGarmentName; },
			"man"						: function(thisPtr:*):* { return kGAMECLASS.monster.mf("man", "woman"); },
			"men"						: function(thisPtr:*):* { return kGAMECLASS.monster.mf("men", "women"); },
			"malefemaleherm"			: function(thisPtr:*):* { return kGAMECLASS.monster.maleFemaleHerm(); },
			"master"					: function(thisPtr:*):* { return kGAMECLASS.monster.mf("master","mistress"); },
			"multicock"					: function(thisPtr:*):* { return kGAMECLASS.monster.multiCockDescriptLight(); },
			"multicockdescriptlight"	: function(thisPtr:*):* { return kGAMECLASS.monster.multiCockDescriptLight(); },
			"name"						: function(thisPtr:*):* { return kGAMECLASS.monster.short;},
			"nipple"					: function(thisPtr:*):* { return kGAMECLASS.monster.nippleDescript(0);},
			"nipples"					: function(thisPtr:*):* { return kGAMECLASS.monster.nippleDescript(0) + "s";},
			"onecock"					: function(thisPtr:*):* { return kGAMECLASS.monster.oMultiCockDesc();},
			"pussy"						: function(thisPtr:*):* { return kGAMECLASS.monster.vaginaDescript(); },
			"sack"						: function(thisPtr:*):* { return kGAMECLASS.monster.sackDescript(); },
			"sheath"					: function(thisPtr:*):* { return kGAMECLASS.monster.sheathDescription(); },
			"shield"					: function(thisPtr:*):* { return kGAMECLASS.monster.shieldName; },
			"skin"						: function(thisPtr:*):* {
				return kGAMECLASS.monster.skin.describe('skin',false,false);
			},
			"skin.noadj": function(thisPtr:*):* {
				return kGAMECLASS.monster.skin.describe('skin',true,false);
			},
			"skin.notone": function(thisPtr:*):* {
				return kGAMECLASS.monster.skin.describe('skin',false,true);
			},
			"skin.type": function(thisPtr:*):* {
				return kGAMECLASS.monster.skin.describe('skin',true,true);
			},
			"skin.color": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.monster.skin.tone;
			},
			"skin.isare": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.monster.skin.isAre();
			},
			"skin.vs": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.monster.skin.isAre("s","");
			},
			"skinfurscales"				: function(thisPtr:*):* {
				return kGAMECLASS.monster.skin.describe('coat');
			},
			"skintone"					: function(thisPtr:*):* {
				return kGAMECLASS.monster.skinTone;
			},
			"tallness"					: function(thisPtr:*):* { return kGAMECLASS.measurements.footInchOrMetres(kGAMECLASS.monster.tallness); },
			"uppergarment"				: function(thisPtr:*):* { return kGAMECLASS.monster.upperGarmentName; },
			"vag"						: function(thisPtr:*):* { return kGAMECLASS.monster.vaginaDescript(); },
			"vagina"					: function(thisPtr:*):* { return kGAMECLASS.monster.vaginaDescript(); },
			"vagorass"					: function(thisPtr:*):* { return (kGAMECLASS.monster.hasVagina() ? kGAMECLASS.monster.vaginaDescript() : kGAMECLASS.monster.assholeDescript()); },
			"weapon"					: function(thisPtr:*):* { return kGAMECLASS.monster.weaponName;},
			"weaponname"				: function(thisPtr:*):* { return kGAMECLASS.monster.weaponName; },
			"weaponrangename"			: function(thisPtr:*):* { return kGAMECLASS.monster.weaponRangeName; },
			"cockplural"				: function(thisPtr:*):* { return (kGAMECLASS.monster.cocks.length == 1) ? "cock" : "cocks"; },
			"dickplural"				: function(thisPtr:*):* { return (kGAMECLASS.monster.cocks.length == 1) ? "dick" : "dicks"; },
			"headplural"				: function(thisPtr:*):* { return (kGAMECLASS.monster.cocks.length == 1) ? "head" : "heads"; },
			"prickplural"				: function(thisPtr:*):* { return (kGAMECLASS.monster.cocks.length == 1) ? "prick" : "pricks"; },
			"boy"						: function(thisPtr:*):* { return kGAMECLASS.monster.mf("boy", "girl"); },
			"guy"						: function(thisPtr:*):* { return kGAMECLASS.monster.mf("guy", "girl"); },
			"wings"						: function(thisPtr:*):* { return kGAMECLASS.monster.wingsDescript(); },
			"tail"						: function(thisPtr:*):* { return kGAMECLASS.monster.tailDescript(); },
			"onetail"					: function(thisPtr:*):* { return kGAMECLASS.monster.oneTailDescript(); }
		};


		// These tags take a two-word tag with a **numberic** attribute for lookup.
		// [object NUMERIC-attribute]
		// if "NUMERIC-attribute" can be cast to a Number, the parser looks for "object" in twoWordNumericTagsLookup.
		// If it finds twoWordNumericTagsLookup["object"], it calls the anonymous function stored with said key "object"
		// like so: twoWordNumericTagsLookup["object"](Number("NUMERIC-attribute"))
		//
		// if attribute cannot be case to a number, the parser looks for "object" in twoWordTagsLookup.
		public var twoWordNumericTagsLookup:Object =
		{
				"cockfit":
					function(thisPtr:*, aspect:*):*
					{
						if(!kGAMECLASS.player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
						else
						{
							if(kGAMECLASS.player.cockThatFits(aspect) >= 0) return kGAMECLASS.player.cockDescript(kGAMECLASS.player.cockThatFits(aspect));
							else return kGAMECLASS.player.cockDescript(kGAMECLASS.player.smallestCockIndex());
						}
					},
				"cockfit2":
					function(thisPtr:*, aspect:*):*
					{
						if(!kGAMECLASS.player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
						else {
							if(kGAMECLASS.player.cockThatFits2(aspect) >= 0) return kGAMECLASS.player.cockDescript(kGAMECLASS.player.cockThatFits2(aspect));
							else return kGAMECLASS.player.cockDescript(kGAMECLASS.player.smallestCockIndex());
						}
					},
				"cockheadfit":
					function(thisPtr:*, aspect:*):*
					{
						if (!kGAMECLASS.player.hasCock())
						{
							return "<b>(Attempt to parse cockhead when none present.)</b>";
						}
						else {
							if(kGAMECLASS.player.cockThatFits(aspect) >= 0) return kGAMECLASS.player.cockHead(kGAMECLASS.player.cockThatFits(aspect));
							else return kGAMECLASS.player.cockHead(kGAMECLASS.player.smallestCockIndex());
						}
					},
				"cockheadfit2":
					function(thisPtr:*, aspect:*):*
					{
						if(!kGAMECLASS.player.hasCock()) return "<b>(Attempt to parse cockhead when none present.)</b>";
						else {
							if(kGAMECLASS.player.cockThatFits2(aspect) >= 0) return kGAMECLASS.player.cockHead(kGAMECLASS.player.cockThatFits2(aspect));
							else return kGAMECLASS.player.cockHead(kGAMECLASS.player.smallestCockIndex());
						}
					},
				"cock":
					function(thisPtr:*, aspect:*):*
					{
						if(!kGAMECLASS.player.hasCock()) return "<b>(Attempt to parse cock when none present.)</b>";
						else
						{
							if(aspect-1 >= 0 && aspect-1 < kGAMECLASS.player.cockTotal()) return kGAMECLASS.player.cockDescript(aspect - 1);
							else return "<b>(Attempt To Parse CockDescript for Invalid Cock)</b>";
						}
					},
				"cockhead":
					function(thisPtr:*, aspect:*):*
					{
						if(!kGAMECLASS.player.hasCock()) return "<b>(Attempt to parse cockHead when none present.)</b>";
						else
						{
							var intAspect:int = int(aspect - 1);
							if (intAspect >= 0 && intAspect < kGAMECLASS.player.cockTotal()) return kGAMECLASS.player.cockHead(intAspect);
							else return "<b>(Attempt To Parse CockHeadDescript for Invalid Cock)</b>";
						}
					}

		};
		private static function skinDescriptionFn(layer:String,noAdj:Boolean,noTone:Boolean):Function {
			return function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.describe(layer,noAdj,noTone)
		}
		}
		public var skinLookups:Object = {
			"skin": skinDescriptionFn("skin", false, false),
			"noadj": skinDescriptionFn("skin", true, false),
			"notone": skinDescriptionFn("skin", false, true),
			"nocolor": skinDescriptionFn("skin", false, true),
			"type": skinDescriptionFn("skin", true, true),
			"color": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.color;
			},
			"color2": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.color2;
			},
			"isare": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.isAre();
			},
			"vs": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.isAre("s","");
			},
			"base": skinDescriptionFn("base", false, false),
			"base.noadj": skinDescriptionFn("base", true, false),
			"base.notone": skinDescriptionFn("base", false, true),
			"base.nocolor": skinDescriptionFn("base", false, true),
			"base.type": skinDescriptionFn("base", true, true),
			"base.color": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.base.color;
			},
			"base.color2": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.base.color2;
			},
			"base.vs": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.base.isAre("s", "");
			},
			"base.isare": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.base.isAre();
			},
			"coat": skinDescriptionFn("coat", false, false),
			"coat.noadj": skinDescriptionFn("coat", true, false),
			"coat.notone": skinDescriptionFn("coat", false, true),
			"coat.nocolor": skinDescriptionFn("coat", false, true),
			"coat.type": skinDescriptionFn("coat", true, true),
			"coat.vs": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.coat.isAre("s", "");
			},
			"coat.isare": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.coat.isAre();
			},
			"coat.color": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.coatColor;
			},
			"coat.color2": function (thisPtr:*, aspect:*):* {
				return kGAMECLASS.player.skin.coat.color2;
			},
			"full": skinDescriptionFn("full", false, false),
			"full.noadj": skinDescriptionFn("full", true, false),
			"full.notone": skinDescriptionFn("full", false, true),
			"full.nocolor": skinDescriptionFn("full", false, true),
			"full.type": skinDescriptionFn("full", true, true)
		};
		public var faceLookups:Object = {
			"full": function(thisPtr:*,aspect:*):*{
				return kGAMECLASS.player.facePart.describe(false,true);
			}
		};
		// These tags take an ascii attribute for lookup.
		// [object attribute]
		// if attribute cannot be cast to a number, the parser looks for "object" in twoWordTagsLookup,
		// and then uses the corresponding object to determine the value of "attribute", by looking for
		// "attribute" twoWordTagsLookup["object"]["attribute"]
		public var twoWordTagsLookup:Object =
		{
			// NPCs:
			"rubi"		: rubiLookups,
			"arian"		: arianLookups,
			"monster"	: monsterLookups,

			// PC Attributes:

			"cock"		: cockLookups,
			"cockhead"	: cockHeadLookups,

			"skin"      : skinLookups,
			"face"      : faceLookups
		}
