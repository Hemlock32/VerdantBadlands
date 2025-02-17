/*
The /tg/ codebase allows mixing of hardcoded and dynamically-loaded z-levels.
Z-levels can be reordered as desired and their properties are set by "traits".
See map_config.dm for how a particular station's traits may be chosen.
The list DEFAULT_MAP_TRAITS at the bottom of this file should correspond to
the maps that are hardcoded, as set in _maps/_basemap.dm. SSmapping is
responsible for loading every non-hardcoded z-level.

As of 2018-02-04, the typical z-levels for a single-level station are:
1: CentCom
2: Station
3-4: Randomized space
5: Mining
6: City of Cogs
7-11: Randomized space
12: Empty space
13: Transit space

Multi-Z stations are supported and multi-Z mining and away missions would
require only minor tweaks.
*/

// helpers for modifying jobs, used in various job_changes.dm files
#define MAP_JOB_CHECK if(SSmapping.config.map_name != JOB_MODIFICATION_MAP_NAME) { return; }
#define MAP_JOB_CHECK_BASE if(SSmapping.config.map_name != JOB_MODIFICATION_MAP_NAME) { return ..(); }
#define MAP_REMOVE_JOB(jobpath) /datum/job/##jobpath/map_check() { return FALSE; }

#define SPACERUIN_MAP_EDGE_PAD 15

// traits
// boolean - marks a level as having that property if present
#define ZTRAIT_CENTCOM "CentCom"
#define ZTRAIT_STATION "Station"
#define ZTRAIT_SURFACE "Surface"
#define ZTRAIT_MINING "Mining"
#define ZTRAIT_REEBE "Reebe"
#define ZTRAIT_RESERVED "Transit/Reserved"
#define ZTRAIT_AWAY "Away Mission"
#define ZTRAIT_VR "Virtual Reality"
#define ZTRAIT_SPACE_RUINS "Space Ruins"
#define ZTRAIT_LAVA_RUINS "Lava Ruins"
#define ZTRAIT_ICE_RUINS "Ice Ruins"
#define ZTRAIT_ICE_RUINS_UNDERGROUND "Ice Ruins Underground"
#define ZTRAIT_ISOLATED_RUINS "Isolated Ruins" //Placing ruins on z levels with this trait will use turf reservation instead of usual placement.
#define ZTRAIT_VIRTUAL_REALITY "Virtual Reality"
#define ZTRAIT_DUNGEON "Dungeons"
#define ZTRAIT_ABOVE "Above"
//boolean - weather types that occur on the level
#define ZTRAIT_SNOWSTORM "Weather_Snowstorm"
#define ZTRAIT_ACIDRAIN "Weather_Acidrain"

// number - bombcap is multiplied by this before being applied to bombs
#define ZTRAIT_BOMBCAP_MULTIPLIER "Bombcap Multiplier"

// number - default gravity if there's no gravity generators or area overrides present
#define ZTRAIT_GRAVITY "Gravity"

///boolean - does this z disable parallax?
#define ZTRAIT_NOPARALLAX "No Parallax"

/// boolean - does this z prevent xray/meson/thermal vision
#define ZTRAIT_NOXRAY "No X-Ray"

/// boolean - does this z prevent ghosts from observing it
#define ZTRAIT_SECRET "Secret"

// numeric offsets - e.g. {"Down": -1} means that chasms will fall to z - 1 rather than oblivion
#define ZTRAIT_UP "Up"
#define ZTRAIT_DOWN "Down"

// enum - how space transitions should affect this level
#define ZTRAIT_LINKAGE "Linkage"
	// UNAFFECTED if absent - no space transitions
	#define UNAFFECTED null
	// SELFLOOPING - space transitions always self-loop
	#define SELFLOOPING "Self"
	// CROSSLINKED - mixed in with the cross-linked space pool
	#define CROSSLINKED "Cross"

// string - type path of the z-level's baseturf (defaults to space)
#define ZTRAIT_BASETURF "Baseturf"

// default trait definitions, used by SSmapping
#define ZTRAITS_CENTCOM list(ZTRAIT_CENTCOM = TRUE)
#define ZTRAITS_STATION list(ZTRAIT_STATION = TRUE)
#define ZTRAITS_SPACE list(ZTRAIT_SPACE_RUINS = TRUE)
#define ZTRAITS_LAVALAND list(\
	ZTRAIT_MINING = TRUE, \
	ZTRAIT_LAVA_RUINS = TRUE, \
	ZTRAIT_BOMBCAP_MULTIPLIER = 5, \
	ZTRAIT_BASETURF = /turf/open/lava/smooth/lava_land_surface)
#define ZTRAITS_REEBE list(ZTRAIT_REEBE = TRUE, ZTRAIT_BOMBCAP_MULTIPLIER = 0.5)
#define ZTRAITS_VR list(ZTRAIT_VIRTUAL_REALITY = TRUE, ZTRAIT_AWAY = TRUE)
#define ZTRAITS_DUNGEON list(ZTRAIT_DUNGEON = TRUE)
#define ZTRAITS_ABOVE list(ZTRAIT_ABOVE = TRUE)

#define DL_NAME "name"
#define DL_TRAITS "traits"
#define DECLARE_LEVEL(NAME, TRAITS) list(DL_NAME = NAME, DL_TRAITS = TRAITS)

// must correspond to _basemap.dm for things to work correctly
#define DEFAULT_MAP_TRAITS list(\
	DECLARE_LEVEL("CentCom", ZTRAITS_CENTCOM),\
)

// Camera lock flags
#define CAMERA_LOCK_STATION 1
#define CAMERA_LOCK_MINING 2
#define CAMERA_LOCK_CENTCOM 4
#define CAMERA_LOCK_REEBE 8

//Reserved/Transit turf type
#define RESERVED_TURF_TYPE /turf/open/space/basic			//What the turf is when not being used

//Ruin Generation

#define PLACEMENT_TRIES 0 //How many times we try to fit the ruin somewhere until giving up (really should just swap to some packing algo)

#define PLACE_DEFAULT "random"
#define PLACE_SAME_Z "same" //On same z level as original ruin
#define PLACE_SPACE_RUIN "space" //On space ruin z level(s)
#define PLACE_LAVA_RUIN "lavaland" //On lavaland ruin z levels(s)
#define PLACE_BELOW "below" //On z levl below - centered on same tile
#define PLACE_ISOLATED "isolated" //On isolated ruin z level
//Map type stuff.
#define MAP_TYPE_STATION "station"

//Random z-levels name defines.
#define AWAY_MISSION_NAME "Away Mission"
#define VIRT_REALITY_NAME "Virtual Reality"

#define Z_FORCE_NORTH	"Force North"
#define Z_FORCE_SOUTH	"Force South"
#define Z_FORCE_EAST	"Force East"
#define Z_FORCE_WEST	"Force West"
