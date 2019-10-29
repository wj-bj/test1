// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

#pragma target 3.0

fixed4 _Color;
sampler2D _MainTex;
half _Glossiness;
half _Metallic;

uniform float _FurLength;
uniform float _Cutoff;
uniform float _CutoffEnd;
uniform float _EdgeFade;

uniform fixed3 _Gravity;
uniform fixed _GravityStrength;

uniform float3 _Position;

void vert (inout appdata_full v)
{

	float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
	float3 pos = _Position - worldPos;
	float le = length(pos);
	float weight = 1.0;
	float windweight = 1.0;

	float3 gravity = _Gravity;
	float gs = _GravityStrength;
	
	gravity *= weight;
	weight = max(0, (5 - le));
	
	fixed3 direction = lerp(v.normal, _Gravity * _GravityStrength + v.normal * (1- _GravityStrength), FUR_MULTIPLIER);
	direction += float3((sin(_Time.y)*0.6-0.5), 0, cos(_Time.y+1)*0.3);
    direction = lerp(direction, pos, weight);
    direction = normalize(direction);

	//direction *= weight;
	//v.vertex.xyz += direction * _FurLength * FUR_MULTIPLIER * v.color.a;
	//v.vertex.xyz += direction * _FurLength * FUR_MULTIPLIER ;
	v.vertex.xyz += direction * _FurLength * FUR_MULTIPLIER * v.color.a;
	
}

struct Input {
	float2 uv_MainTex;
	float3 viewDir;
};

void surf (Input IN, inout SurfaceOutputStandard o) {
	fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
	o.Albedo = c.rgb;
	o.Metallic = _Metallic;
	o.Smoothness = _Glossiness;

	//o.Alpha = step(_Cutoff, c.a);
	o.Alpha = step(lerp(_Cutoff,_CutoffEnd,FUR_MULTIPLIER), c.a);
	

	float alpha = 1 - (FUR_MULTIPLIER * FUR_MULTIPLIER);
	alpha += dot(IN.viewDir, o.Normal) - _EdgeFade;

	o.Alpha *= alpha;
}