
local Weather = atmos_class();

function Weather:__constructor()

	self.ID = 3;
	self.MaxDarkness = "d";
	self.MaxLightness = "d";
	EventTimeStart = 20
	EventTimeStop = 5
	EventOngoing = false

	if CLIENT then

		-- -- skybox colors
		self.DayColors = {
			TopColor = Vector( 0.32, 0.22, 0.22 ),
			BottomColor	= Vector( 0.05, 0.05, 0.07 ),
			FadeBias = 1,
			HDRScale = 1,
			DuskIntensity	= 0.0,
			DuskScale	= 1.0,
			DuskColor	= Vector( 0.22, 0.23, 0.23 ),
			SunSize = 0,
			SunColor = Vector( 0.83, 0.45, 0.11 )
		};

		self.NightColors = {
			TopColor = Vector( 1, 0.22, 0.22 ),
			BottomColor	= Vector( 0.22, 0.05, 0.07 ),
			FadeBias = 1,
			HDRScale = 0.22,
			DuskIntensity	= 1.0,
			DuskScale	= 0.0,
			DuskColor	= Vector( 0.66, 0.23, 0.23 ),
			SunSize = 0,
			SunColor = Vector( 0, 0.45, 0.11 )
		};

		-- fog values
		self.DayFog = {
			FogStart = 0.0,
			FogEnd = 0.0,
			FogDensity = 0,
			FogColor = Vector( 0.23, 0.23, 0.23 )
		};

		self.NightFog = {
			FogStart = 1.0,
			FogEnd = 100.0,
			FogDensity = 0,
			FogColor = Vector( 0.88, 0.23, 0.23 )
		};

		self.IncomingSounds = {
			"atmos/bloodmoon/incoming.mp3"
		}
		self.StartSounds = {
			"atmos/bloodmoon/starts.mp3"
		}

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

	if CLIENT then 
		local pl = LocalPlayer();
		local pos = LocalPlayer():EyePos();

	end


end

function Weather:Finish()

	self.Valid = false;

	atmos_log( tostring( self ) .. " finish" );

	if CLIENT then
		if ( self.IncomingSound ) then
			self.IncomingSound:FadeOut( 5 );
		end
		if ( self.StartSound ) then
			self.StartSound:FadeOut( 5 );
		end
	end
	EventOngoing = false
end


function Weather:Think()

	if CLIENT then

		if ( !IsValid( LocalPlayer() ) ) then return end

		local pl = LocalPlayer();
		local pos = pl:EyePos();
		
		local nightTime = (CurTime() >= EventTimeStart or CurTime() <= EventTimeStop);
		if (nightTime) then
			if ( EventOngoing ) then 
				return
			end
			EventOngoing = true
			print('EVENT START')
			if CLIENT then
				self.StartSound = CreateSound(pl, table.Random( self.StartSounds ) );
				self.StartSound:PlayEx( 1, 100 );
				pl:PrintMessage(3,'THE BLOOD MOON RISES ONCE AGAIN')
			end
		else
			if ( !EventOngoing ) then 
				return
			end
			EventOngoing = false
			print('EVENT END')
			if CLIENT then
				if ( self.IncomingSound ) then
					self.IncomingSound:FadeOut( 5 );
				end
				if ( self.StartSound ) then
					self.StartSound:FadeOut( 5 );
				end
			end
		end
	
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
