# conanexiles_scripts
This is a collection of gathered sql scripts from the conan exiles server owner community and a few I have modified or created myself.  This collection includes a complete custom item cross referencing table which can be used for many reasons and many custom database views to make your life as a server owner and the lives of your admins much less stressful.


Everything here should be considered as up to date and working unless otherwise.  If anything is not working properly, shoot me a message.


InactiveCleanout and what this does for you:

--This Transfer Pet and Thrall ownership ID's to our custom tables before we remove old event logs

--Remove duplicate owned npc id rows from our custom tables above 

--Remove inactive player/clan pets

--Remove inactive player/clan thralls

--Remove old event logs 

--Custom Decay Settings - Default 3 days - Targets inactive solos and whole clans - One active member saves the clan!*

--Single and Double Foundation/Pillar spam removal

--Crafting Station fix - Fishtraps, Wells, Wheels, Beehives, Alters

--Remove All Corpse's 

--Reset purge scores

--Reinserts server spawned forges and storymode and dlc stuff


*To change your inactive settings, default is set to 3 days removal for my server
one active member saves a clan, otherwise i delete everything u own + ur character and thralls
to change it, open with notepad++ or even notepad(ew)  and change all    -3 days   to    (any amount of days like so -8 days)
