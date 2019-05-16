VAR wiseManFirstVisit = false
VAR testvar = true

->Doctor
===Doctor===
Doctor-The news I have for you is not very good. In her current condition, your loved one will pass away in the coming days.
Hero-Is there anything else that we can do?
Doctor-Unfortunately, we have done all that we can do here. I am sorry.
Hero-...Thank you doctor.
->DONE

===LovedOne===
Loved One-I am sorry to do this to you.
Hero-I will do whatever I can to keep us together
Loved One-Would the Wise Man be able to help?
Hero-I will pay him a visit and see.
Hero-Don't worry Loved One. I will save you.
->DONE

===VilagerOne===
Villager-The weather is fantastic today!
->DONE

===VillagerTwo===
Villager-What a wonderful day to be outside with friends!
->DONE

===VillagerThree===
Villager-This day is beautiful.
Villager-I wish it could go on forever!
->DONE

===WiseMan===
~ wiseManFirstVisit = true
Wise Man-Hello Young Man.
Wise Man-What can I do for you?
Hero-The one that I care for most is about to be taken from this Earth.
Hero-I need to find a way to save her before I lose her.
Wise Man-I see...
Wise Man-What you need is to take this moment and make it last forever.
Wise Man-It will not be easy but I trust your abilities.
Wise Man-You will need to go to the Hourglass at the East wdge of the world.
Wise Man-Once you are there, you will need to break the Hourglass and this will save your Loved One.
Wise Man-Be careful. To the East Side of Day Town there is a Portal that will bring you to your destination.
->DONE

===WiseManRevisit===
Wise Man-You need to break the Hourglass to save your Loved One. Start by heading East, through the Portal.
->DONE

