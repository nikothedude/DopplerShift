/obj/item/clothing/suit/utility/fire/firefighter // outdated but similar sprites, still pretty good
	supported_bodyshapes = list(BODYSHAPE_HUMANOID, BODYSHAPE_TAUR_SNAKE)
	bodyshape_icon_files = list(
		BODYSHAPE_HUMANOID_T = 'icons/mob/clothing/suits/utility.dmi',
		BODYSHAPE_TAUR_SNAKE_T = TAUR_SNAKE_SUIT_FILE
	)
	flags_inv = parent_type::flags_inv | HIDETAURIFCOMPATIBLE
