// "Taur modes" represent the taur organ's general bodyshape, and enable the use of specialized clothing sprites. Used on clothing and /datum/sprite_accessory/taur -
// if a clothing has a compatible sprite for a taur type, its used instead of the usual.
#define STYLE_TAUR_SNAKE (1<<2) //taur-friendly suits
#define STYLE_TAUR_PAW (1<<3)
#define STYLE_TAUR_HOOF (1<<4)
#define STYLE_TAUR_ALL (STYLE_TAUR_SNAKE|STYLE_TAUR_PAW|STYLE_TAUR_HOOF)

// INVENTORY FLAGS BEGIN
/// If this has our taur variant, do we hide our taur part?
#define HIDETAUR (1<<19)
// INVENTORY FLAGS END
