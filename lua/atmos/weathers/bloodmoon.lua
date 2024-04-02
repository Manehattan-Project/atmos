
local Weather = atmos_class();

function Weather:__constructor()

	self.ID = 3;
	self.MaxDarkness = "d";
	self.MaxLightness = "d";

	if CLIENT then

		-- skybox colors
		self.DayColors = {
			TopColor = Vector( 0.66, 0.22, 0.22 ),
			BottomColor	= Vector( 0.05, 0.05, 0.07 ),
			FadeBias = 1,
			HDRScale = 0.26,
			DuskIntensity	= 0.0,
			DuskScale	= 0.0,
			DuskColor	= Vector( 0.66, 0.23, 0.23 ),
			SunSize = 0,
			SunColor = Vector( 0.83, 0.45, 0.11 )
		};

		self.NightColors = {
			TopColor = Vector( 0.88, 0.22, 0.22 ),
			BottomColor	= Vector( 0.05, 0.05, 0.07 ),
			FadeBias = 1,
			HDRScale = 0.26,
			DuskIntensity	= 1.0,
			DuskScale	= 0.0,
			DuskColor	= Vector( 0.66, 0.23, 0.23 ),
			SunSize = 0,
			SunColor = Vector( 1, 0.45, 0.11 )
		};

		-- fog values
		self.DayFog = {
			FogStart = 0.0,
			FogEnd = 0.0,
			FogDensity = 0,
			FogColor = Vector( 0.23, 0.23, 0.23 )
		};

		self.NightFog = {
			FogStart = 40.0,
			FogEnd = 18000.0,
			FogDensity = 0.55,
			FogColor = Vector( 0.88, 0.23, 0.23 )
		};

	end

end

function Weather:__tostring()

	return "Bloodmoon";

end

function Weather:IsValid()

	return self.Valid;

end

function Weather:GetID()

	return self.ID;

end

function Weather:Start()

	self.Valid = true;

	atmos_log( tostring( self ) .. " start" );


end

function Weather:Finish()

	self.Valid = false;

	atmos_log( tostring( self ) .. " finish" );

end

function Weather:Think()

	if CLIENT then

		if ( !IsValid( LocalPlayer() ) ) then return end

		local pl = LocalPlayer();
		local pos = pl:EyePos();
	
	end

end

function Weather:GetSkyColors( time )

	local nightTime = (time >= 20 || time <= 4);

	return (!nightTime && self.DayColors || self.NightColors);

end

function Weather:GetFogValues( time )

	local nightTime = (time >= 20 || time <= 4);

	return (!nightTime && self.DayFog || self.NightFog);

end

function Weather:ShouldUpdateLighting()

	return true;

end

function Weather:ShouldUpdateSky()

	return true;

end

function Weather:ShouldUpdateFog()

	return true;

end

function Weather:ShouldUpdateWind()

	return true;

end

function Weather:IsCloudy()

	return true;

end

if CLIENT then

  function Weather:HUDPaint()

  end

end

Atmos:RegisterWeather( Weather() );
