// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MTE/LWRP/6 Textures"
{
    Properties
    {
		_Control("Control", 2D) = "white" {}
		_ControlExtra("ControlExtra", 2D) = "white" {}
		_Splat0("Layer 1", 2D) = "white" {}
		_Splat1("Layer 2", 2D) = "white" {}
		_Splat2("Layer 3", 2D) = "white" {}
		_Splat3("Layer 4", 2D) = "white" {}
		_Splat4("Layer 5", 2D) = "white" {}
		_Splat5("Layer 6", 2D) = "white" {}
		_Normal0("Normalmap 1", 2D) = "bump" {}
		_Normal1("Normalmap 2", 2D) = "bump" {}
		_Normal2("Normalmap 3", 2D) = "bump" {}
		_Normal3("Normalmap 4", 2D) = "bump" {}
		_Normal4("Normalmap 5", 2D) = "bump" {}
		_Normal5("Normalmap 6", 2D) = "bump" {}
		_Metallic0("Metallic 1", Range( 0 , 1)) = 0
		_Metallic1("Metallic 2", Range( 0 , 1)) = 0
		_Metallic2("Metallic 3", Range( 0 , 1)) = 0
		_Metallic5("Metallic 6", Range( 0 , 1)) = 0
		_Metallic3("Metallic 4", Range( 0 , 1)) = 0
		_Metallic4("Metallic 5", Range( 0 , 1)) = 0.3988698
		_Smoothness0("Smoothness 1", Range( 0 , 1)) = 0.5
		_Smoothness1("Smoothness 2", Range( 0 , 1)) = 0.5
		_Smoothness2("Smoothness 3", Range( 0 , 1)) = 0.5
		_Smoothness3("Smoothness 4", Range( 0 , 1)) = 0.5
		_Smoothness4("Smoothness 5", Range( 0 , 1)) = 0.5
		_Smoothness5("Smoothness 6", Range( 0 , 1)) = 0.5

    }


    SubShader
    {
		LOD 0

		
        Tags { "RenderPipeline"="LightweightPipeline" "RenderType"="Opaque" "Queue"="Geometry-100" }

		Cull Back
		HLSLINCLUDE
		#pragma target 3.0
		ENDHLSL
		
        Pass
        {
			
        	Tags { "LightMode"="LightweightForward" }

        	Name "Base"
			Blend One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
            
        	HLSLPROGRAM
            #define ASE_SRP_VERSION 41000
            #define _NORMALMAP 1

            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            

        	// -------------------------------------
            // Lightweight Pipeline keywords
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile _ _SHADOWS_SOFT
            #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
            
        	// -------------------------------------
            // Unity defined keywords
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile_fog

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing

            #pragma vertex vert
        	#pragma fragment frag

        	

        	#include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/Core.hlsl"
        	#include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/Lighting.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
        	#include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/ShaderGraphFunctions.hlsl"

			sampler2D _Control;
			sampler2D _ControlExtra;
			sampler2D _Splat0;
			sampler2D _Splat1;
			sampler2D _Splat2;
			sampler2D _Splat3;
			sampler2D _Splat4;
			sampler2D _Splat5;
			sampler2D _Normal0;
			sampler2D _Normal1;
			sampler2D _Normal2;
			sampler2D _Normal3;
			sampler2D _Normal4;
			sampler2D _Normal5;
			CBUFFER_START( UnityPerMaterial )
			float4 _Control_ST;
			float4 _ControlExtra_ST;
			float4 _Splat0_ST;
			float4 _Splat1_ST;
			float4 _Splat2_ST;
			float4 _Splat3_ST;
			float4 _Splat4_ST;
			float4 _Splat5_ST;
			float _Metallic0;
			float _Metallic1;
			float _Metallic2;
			float _Metallic3;
			float _Metallic4;
			float _Metallic5;
			float _Smoothness0;
			float _Smoothness1;
			float _Smoothness2;
			float _Smoothness3;
			float _Smoothness4;
			float _Smoothness5;
			CBUFFER_END


            struct GraphVertexInput
            {
                float4 vertex : POSITION;
                float3 ase_normal : NORMAL;
                float4 ase_tangent : TANGENT;
                float4 texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

        	struct GraphVertexOutput
            {
                float4 clipPos                : SV_POSITION;
                float4 lightmapUVOrVertexSH	  : TEXCOORD0;
        		half4 fogFactorAndVertexLight : TEXCOORD1; // x: fogFactor, yzw: vertex light
            	float4 shadowCoord            : TEXCOORD2;
				float4 tSpace0					: TEXCOORD3;
				float4 tSpace1					: TEXCOORD4;
				float4 tSpace2					: TEXCOORD5;
				float4 ase_texcoord7 : TEXCOORD7;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            	UNITY_VERTEX_OUTPUT_STEREO
            };

			float4 WeightedBlend685( half4 Weight , half4 WeightExtra , float4 Layer1 , float4 Layer2 , float4 Layer3 , float4 Layer4 , float4 Layer5 , float4 Layer6 )
			{
				return Layer1 * Weight.r + Layer2 * Weight.g + Layer3 * Weight.b + Layer4 * Weight.a + Layer5 * WeightExtra.r + Layer6 * WeightExtra.g;
			}
			
			float4 WeightedBlend689( half4 Weight , half4 WeightExtra , float4 Layer1 , float4 Layer2 , float4 Layer3 , float4 Layer4 , float4 Layer5 , float4 Layer6 )
			{
				return Layer1 * Weight.r + Layer2 * Weight.g + Layer3 * Weight.b + Layer4 * Weight.a + Layer5 * WeightExtra.r + Layer6 * WeightExtra.g;
			}
			

            GraphVertexOutput vert (GraphVertexInput v  )
        	{
        		GraphVertexOutput o = (GraphVertexOutput)0;
                UNITY_SETUP_INSTANCE_ID(v);
            	UNITY_TRANSFER_INSTANCE_ID(v, o);
        		UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				o.ase_texcoord7.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.zw = 0;
				float3 vertexValue =  float3( 0, 0, 0 ) ;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal =  v.ase_normal ;

        		// Vertex shader outputs defined by graph
                float3 lwWNormal = TransformObjectToWorldNormal(v.ase_normal);
				float3 lwWorldPos = TransformObjectToWorld(v.vertex.xyz);
				float3 lwWTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				float3 lwWBinormal = normalize(cross(lwWNormal, lwWTangent) * v.ase_tangent.w);
				o.tSpace0 = float4(lwWTangent.x, lwWBinormal.x, lwWNormal.x, lwWorldPos.x);
				o.tSpace1 = float4(lwWTangent.y, lwWBinormal.y, lwWNormal.y, lwWorldPos.y);
				o.tSpace2 = float4(lwWTangent.z, lwWBinormal.z, lwWNormal.z, lwWorldPos.z);

                VertexPositionInputs vertexInput = GetVertexPositionInputs(v.vertex.xyz);
                
         		// We either sample GI from lightmap or SH.
        	    // Lightmap UV and vertex SH coefficients use the same interpolator ("float2 lightmapUV" for lightmap or "half3 vertexSH" for SH)
                // see DECLARE_LIGHTMAP_OR_SH macro.
        	    // The following funcions initialize the correct variable with correct data
        	    OUTPUT_LIGHTMAP_UV(v.texcoord1, unity_LightmapST, o.lightmapUVOrVertexSH.xy);
        	    OUTPUT_SH(lwWNormal, o.lightmapUVOrVertexSH.xyz);

        	    half3 vertexLight = VertexLighting(vertexInput.positionWS, lwWNormal);
        	    half fogFactor = ComputeFogFactor(vertexInput.positionCS.z);
        	    o.fogFactorAndVertexLight = half4(fogFactor, vertexLight);
        	    o.clipPos = vertexInput.positionCS;

        	#ifdef _MAIN_LIGHT_SHADOWS
        		o.shadowCoord = GetShadowCoord(vertexInput);
        	#endif
        		return o;
        	}

        	half4 frag (GraphVertexOutput IN  ) : SV_Target
            {
            	UNITY_SETUP_INSTANCE_ID(IN);

        		float3 WorldSpaceNormal = normalize(float3(IN.tSpace0.z,IN.tSpace1.z,IN.tSpace2.z));
				float3 WorldSpaceTangent = float3(IN.tSpace0.x,IN.tSpace1.x,IN.tSpace2.x);
				float3 WorldSpaceBiTangent = float3(IN.tSpace0.y,IN.tSpace1.y,IN.tSpace2.y);
				float3 WorldSpacePosition = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 WorldSpaceViewDirection = SafeNormalize( _WorldSpaceCameraPos.xyz  - WorldSpacePosition );
    
				float2 uv0_Control = IN.ase_texcoord7.xy * _Control_ST.xy + _Control_ST.zw;
				float4 tex2DNode6 = tex2D( _Control, uv0_Control );
				float4 Weight85 = tex2DNode6;
				float2 uv0_ControlExtra = IN.ase_texcoord7.xy * _ControlExtra_ST.xy + _ControlExtra_ST.zw;
				float4 tex2DNode86 = tex2D( _ControlExtra, uv0_ControlExtra );
				float4 WeightExtra85 = tex2DNode86;
				float2 uv0_Splat0 = IN.ase_texcoord7.xy * _Splat0_ST.xy + _Splat0_ST.zw;
				float4 Layer185 = tex2D( _Splat0, uv0_Splat0 );
				float2 uv0_Splat1 = IN.ase_texcoord7.xy * _Splat1_ST.xy + _Splat1_ST.zw;
				float4 Layer285 = tex2D( _Splat1, uv0_Splat1 );
				float2 uv0_Splat2 = IN.ase_texcoord7.xy * _Splat2_ST.xy + _Splat2_ST.zw;
				float4 Layer385 = tex2D( _Splat2, uv0_Splat2 );
				float2 uv0_Splat3 = IN.ase_texcoord7.xy * _Splat3_ST.xy + _Splat3_ST.zw;
				float4 Layer485 = tex2D( _Splat3, uv0_Splat3 );
				float2 uv0_Splat4 = IN.ase_texcoord7.xy * _Splat4_ST.xy + _Splat4_ST.zw;
				float4 Layer585 = tex2D( _Splat4, uv0_Splat4 );
				float2 uv0_Splat5 = IN.ase_texcoord7.xy * _Splat5_ST.xy + _Splat5_ST.zw;
				float4 Layer685 = tex2D( _Splat5, uv0_Splat5 );
				float4 localWeightedBlend685 = WeightedBlend685( Weight85 , WeightExtra85 , Layer185 , Layer285 , Layer385 , Layer485 , Layer585 , Layer685 );
				
				float4 Weight89 = tex2DNode6;
				float4 WeightExtra89 = tex2DNode86;
				float4 Layer189 = float4( UnpackNormalScale( tex2D( _Normal0, uv0_Splat0 ), 1.0f ) , 0.0 );
				float4 Layer289 = float4( UnpackNormalScale( tex2D( _Normal1, uv0_Splat1 ), 1.0f ) , 0.0 );
				float4 Layer389 = float4( UnpackNormalScale( tex2D( _Normal2, uv0_Splat2 ), 1.0f ) , 0.0 );
				float4 Layer489 = float4( UnpackNormalScale( tex2D( _Normal3, uv0_Splat3 ), 1.0f ) , 0.0 );
				float4 Layer589 = float4( UnpackNormalScale( tex2D( _Normal4, uv0_Splat4 ), 1.0f ) , 0.0 );
				float4 Layer689 = float4( UnpackNormalScale( tex2D( _Normal5, uv0_Splat5 ), 1.0f ) , 0.0 );
				float4 localWeightedBlend689 = WeightedBlend689( Weight89 , WeightExtra89 , Layer189 , Layer289 , Layer389 , Layer489 , Layer589 , Layer689 );
				
				float4 appendResult100 = (float4(_Metallic0 , _Metallic1 , _Metallic2 , _Metallic3));
				float dotResult97 = dot( tex2DNode6 , appendResult100 );
				float4 appendResult109 = (float4(_Metallic4 , _Metallic5 , 0.0 , 0.0));
				float dotResult110 = dot( tex2DNode6 , appendResult109 );
				
				float4 appendResult101 = (float4(_Smoothness0 , _Smoothness1 , _Smoothness2 , _Smoothness3));
				float dotResult102 = dot( tex2DNode6 , appendResult101 );
				float4 appendResult114 = (float4(_Smoothness4 , _Smoothness5 , 0.0 , 0.0));
				float dotResult112 = dot( tex2DNode6 , appendResult114 );
				
				
		        float3 Albedo = localWeightedBlend685.xyz;
				float3 Normal = localWeightedBlend689.xyz;
				float3 Emission = 0;
				float3 Specular = float3(0.5, 0.5, 0.5);
				float Metallic = ( dotResult97 + dotResult110 );
				float Smoothness = ( dotResult102 + dotResult112 );
				float Occlusion = 1;
				float Alpha = 1;
				float AlphaClipThreshold = 0;

        		InputData inputData;
        		inputData.positionWS = WorldSpacePosition;

        #ifdef _NORMALMAP
        	    inputData.normalWS = normalize(TransformTangentToWorld(Normal, half3x3(WorldSpaceTangent, WorldSpaceBiTangent, WorldSpaceNormal)));
        #else
            #if !SHADER_HINT_NICE_QUALITY
                inputData.normalWS = WorldSpaceNormal;
            #else
        	    inputData.normalWS = normalize(WorldSpaceNormal);
            #endif
        #endif

        #if !SHADER_HINT_NICE_QUALITY
        	    // viewDirection should be normalized here, but we avoid doing it as it's close enough and we save some ALU.
        	    inputData.viewDirectionWS = WorldSpaceViewDirection;
        #else
        	    inputData.viewDirectionWS = normalize(WorldSpaceViewDirection);
        #endif

        	    inputData.shadowCoord = IN.shadowCoord;

        	    inputData.fogCoord = IN.fogFactorAndVertexLight.x;
        	    inputData.vertexLighting = IN.fogFactorAndVertexLight.yzw;
        	    inputData.bakedGI = SAMPLE_GI(IN.lightmapUVOrVertexSH.xy, IN.lightmapUVOrVertexSH.xyz, inputData.normalWS);

        		half4 color = LightweightFragmentPBR(
        			inputData, 
        			Albedo, 
        			Metallic, 
        			Specular, 
        			Smoothness, 
        			Occlusion, 
        			Emission, 
        			Alpha);

			#ifdef TERRAIN_SPLAT_ADDPASS
				color.rgb = MixFogColor(color.rgb, half3( 0, 0, 0 ), IN.fogFactorAndVertexLight.x );
			#else
				color.rgb = MixFog(color.rgb, IN.fogFactorAndVertexLight.x);
			#endif

        #if _AlphaClip
        		clip(Alpha - AlphaClipThreshold);
        #endif

		#if ASE_LW_FINAL_COLOR_ALPHA_MULTIPLY
				color.rgb *= color.a;
		#endif
        		return color;
            }

        	ENDHLSL
        }

		
        Pass
        {
			
        	Name "ShadowCaster"
            Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual

            HLSLPROGRAM
            #define ASE_SRP_VERSION 41000

            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing

            #pragma vertex ShadowPassVertex
            #pragma fragment ShadowPassFragment

            

            #include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

            struct GraphVertexInput
            {
                float4 vertex : POSITION;
                float3 ase_normal : NORMAL;
				
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

			CBUFFER_START( UnityPerMaterial )
			float4 _Control_ST;
			float4 _ControlExtra_ST;
			float4 _Splat0_ST;
			float4 _Splat1_ST;
			float4 _Splat2_ST;
			float4 _Splat3_ST;
			float4 _Splat4_ST;
			float4 _Splat5_ST;
			float _Metallic0;
			float _Metallic1;
			float _Metallic2;
			float _Metallic3;
			float _Metallic4;
			float _Metallic5;
			float _Smoothness0;
			float _Smoothness1;
			float _Smoothness2;
			float _Smoothness3;
			float _Smoothness4;
			float _Smoothness5;
			CBUFFER_END


        	struct VertexOutput
        	{
        	    float4 clipPos      : SV_POSITION;
                
                UNITY_VERTEX_INPUT_INSTANCE_ID
        	};

			
            // x: global clip space bias, y: normal world space bias
            float4 _ShadowBias;
            float3 _LightDirection;

            VertexOutput ShadowPassVertex(GraphVertexInput v )
        	{
        	    VertexOutput o;
        	    UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);

				
				float3 vertexValue =  float3(0,0,0) ;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal =  v.ase_normal ;

        	    float3 positionWS = TransformObjectToWorld(v.vertex.xyz);
                float3 normalWS = TransformObjectToWorldDir(v.ase_normal);

                float invNdotL = 1.0 - saturate(dot(_LightDirection, normalWS));
                float scale = invNdotL * _ShadowBias.y;

                // normal bias is negative since we want to apply an inset normal offset
                positionWS = _LightDirection * _ShadowBias.xxx + positionWS;
				positionWS = normalWS * scale.xxx + positionWS;
                float4 clipPos = TransformWorldToHClip(positionWS);

                // _ShadowBias.x sign depens on if platform has reversed z buffer
                //clipPos.z += _ShadowBias.x;

        	#if UNITY_REVERSED_Z
        	    clipPos.z = min(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
        	#else
        	    clipPos.z = max(clipPos.z, clipPos.w * UNITY_NEAR_CLIP_VALUE);
        	#endif
                o.clipPos = clipPos;

        	    return o;
        	}

            half4 ShadowPassFragment(VertexOutput IN  ) : SV_TARGET
            {
                UNITY_SETUP_INSTANCE_ID(IN);

               

				float Alpha = 1;
				float AlphaClipThreshold = AlphaClipThreshold;

         #if _AlphaClip
        		clip(Alpha - AlphaClipThreshold);
        #endif
                return 0;
            }

            ENDHLSL
        }

		
        Pass
        {
			
        	Name "DepthOnly"
            Tags { "LightMode"="DepthOnly" }

            ZWrite On
			ColorMask 0

            HLSLPROGRAM
            #define ASE_SRP_VERSION 41000

            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing

            #pragma vertex vert
            #pragma fragment frag

            

            #include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			CBUFFER_START( UnityPerMaterial )
			float4 _Control_ST;
			float4 _ControlExtra_ST;
			float4 _Splat0_ST;
			float4 _Splat1_ST;
			float4 _Splat2_ST;
			float4 _Splat3_ST;
			float4 _Splat4_ST;
			float4 _Splat5_ST;
			float _Metallic0;
			float _Metallic1;
			float _Metallic2;
			float _Metallic3;
			float _Metallic4;
			float _Metallic5;
			float _Smoothness0;
			float _Smoothness1;
			float _Smoothness2;
			float _Smoothness3;
			float _Smoothness4;
			float _Smoothness5;
			CBUFFER_END


            struct GraphVertexInput
            {
                float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

        	struct VertexOutput
        	{
        	    float4 clipPos      : SV_POSITION;
                
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
        	};

			           

            VertexOutput vert(GraphVertexInput v  )
            {
                VertexOutput o = (VertexOutput)0;
        	    UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				
				float3 vertexValue =  float3(0,0,0) ;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal =  v.ase_normal ;

        	    o.clipPos = TransformObjectToHClip(v.vertex.xyz);
        	    return o;
            }

            half4 frag(VertexOutput IN  ) : SV_TARGET
            {
                UNITY_SETUP_INSTANCE_ID(IN);

				

				float Alpha = 1;
				float AlphaClipThreshold = AlphaClipThreshold;

         #if _AlphaClip
        		clip(Alpha - AlphaClipThreshold);
        #endif
                return 0;
            }
            ENDHLSL
        }

        // This pass it not used during regular rendering, only for lightmap baking.
		
        Pass
        {
			
        	Name "Meta"
            Tags { "LightMode"="Meta" }

            Cull Off

            HLSLPROGRAM
            #define ASE_SRP_VERSION 41000

            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x

            #pragma vertex vert
            #pragma fragment frag

            

			uniform float4 _MainTex_ST;
			
            #include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/MetaInput.hlsl"
            #include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			sampler2D _Control;
			sampler2D _ControlExtra;
			sampler2D _Splat0;
			sampler2D _Splat1;
			sampler2D _Splat2;
			sampler2D _Splat3;
			sampler2D _Splat4;
			sampler2D _Splat5;
			CBUFFER_START( UnityPerMaterial )
			float4 _Control_ST;
			float4 _ControlExtra_ST;
			float4 _Splat0_ST;
			float4 _Splat1_ST;
			float4 _Splat2_ST;
			float4 _Splat3_ST;
			float4 _Splat4_ST;
			float4 _Splat5_ST;
			float _Metallic0;
			float _Metallic1;
			float _Metallic2;
			float _Metallic3;
			float _Metallic4;
			float _Metallic5;
			float _Smoothness0;
			float _Smoothness1;
			float _Smoothness2;
			float _Smoothness3;
			float _Smoothness4;
			float _Smoothness5;
			CBUFFER_END


            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature EDITOR_VISUALIZATION


            struct GraphVertexInput
            {
                float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

        	struct VertexOutput
        	{
        	    float4 clipPos      : SV_POSITION;
                float4 ase_texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
        	};

			float4 WeightedBlend685( half4 Weight , half4 WeightExtra , float4 Layer1 , float4 Layer2 , float4 Layer3 , float4 Layer4 , float4 Layer5 , float4 Layer6 )
			{
				return Layer1 * Weight.r + Layer2 * Weight.g + Layer3 * Weight.b + Layer4 * Weight.a + Layer5 * WeightExtra.r + Layer6 * WeightExtra.g;
			}
			

            VertexOutput vert(GraphVertexInput v  )
            {
                VertexOutput o = (VertexOutput)0;
        	    UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;

				float3 vertexValue =  float3(0,0,0) ;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal =  v.ase_normal ;
				
                o.clipPos = MetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST);
        	    return o;
            }

            half4 frag(VertexOutput IN  ) : SV_TARGET
            {
                UNITY_SETUP_INSTANCE_ID(IN);

           		float2 uv0_Control = IN.ase_texcoord.xy * _Control_ST.xy + _Control_ST.zw;
           		float4 tex2DNode6 = tex2D( _Control, uv0_Control );
           		float4 Weight85 = tex2DNode6;
           		float2 uv0_ControlExtra = IN.ase_texcoord.xy * _ControlExtra_ST.xy + _ControlExtra_ST.zw;
           		float4 tex2DNode86 = tex2D( _ControlExtra, uv0_ControlExtra );
           		float4 WeightExtra85 = tex2DNode86;
           		float2 uv0_Splat0 = IN.ase_texcoord.xy * _Splat0_ST.xy + _Splat0_ST.zw;
           		float4 Layer185 = tex2D( _Splat0, uv0_Splat0 );
           		float2 uv0_Splat1 = IN.ase_texcoord.xy * _Splat1_ST.xy + _Splat1_ST.zw;
           		float4 Layer285 = tex2D( _Splat1, uv0_Splat1 );
           		float2 uv0_Splat2 = IN.ase_texcoord.xy * _Splat2_ST.xy + _Splat2_ST.zw;
           		float4 Layer385 = tex2D( _Splat2, uv0_Splat2 );
           		float2 uv0_Splat3 = IN.ase_texcoord.xy * _Splat3_ST.xy + _Splat3_ST.zw;
           		float4 Layer485 = tex2D( _Splat3, uv0_Splat3 );
           		float2 uv0_Splat4 = IN.ase_texcoord.xy * _Splat4_ST.xy + _Splat4_ST.zw;
           		float4 Layer585 = tex2D( _Splat4, uv0_Splat4 );
           		float2 uv0_Splat5 = IN.ase_texcoord.xy * _Splat5_ST.xy + _Splat5_ST.zw;
           		float4 Layer685 = tex2D( _Splat5, uv0_Splat5 );
           		float4 localWeightedBlend685 = WeightedBlend685( Weight85 , WeightExtra85 , Layer185 , Layer285 , Layer385 , Layer485 , Layer585 , Layer685 );
           		
				
		        float3 Albedo = localWeightedBlend685.xyz;
				float3 Emission = 0;
				float Alpha = 1;
				float AlphaClipThreshold = 0;

         #if _AlphaClip
        		clip(Alpha - AlphaClipThreshold);
        #endif

                MetaInput metaInput = (MetaInput)0;
                metaInput.Albedo = Albedo;
                metaInput.Emission = Emission;
                
                return MetaFragment(metaInput);
            }
            ENDHLSL
        }
		
    }
    
	CustomEditor "ASEMaterialInspector"
	
}
/*ASEBEGIN
Version=17300
420;886;1066;1004;4963.905;3376.329;7.616306;True;True
Node;AmplifyShaderEditor.TexturePropertyNode;45;-1638.697,1011.048;Float;True;Property;_Splat3;Layer 4;5;0;Create;False;0;0;False;0;None;c68296334e691ed45b62266cbc716628;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;41;-1664.268,307.7433;Float;True;Property;_Splat2;Layer 3;4;0;Create;False;0;0;False;0;None;0f565f3ac250a744ca75a8ff0c9d2108;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;37;-1656.968,-331.6389;Float;True;Property;_Splat1;Layer 2;3;0;Create;False;0;0;False;0;None;aa2736185cb6ec24088c0080e5ff6b1d;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;103;-1658.644,-1645.802;Float;True;Property;_Control;Control;0;0;Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;106;-1656.335,-1383.058;Float;True;Property;_ControlExtra;ControlExtra;1;0;Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;19;-1654.834,-945.6718;Float;True;Property;_Splat0;Layer 1;2;0;Create;False;0;0;False;0;None;44b550da39bfea448a4be6b25b1b626c;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;115;-1662.076,2322.514;Float;True;Property;_Splat5;Layer 6;7;0;Create;False;0;0;False;0;None;18a1c5cc7397b9847816e03e17440d92;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;62;-1675.919,1715.992;Float;True;Property;_Splat4;Layer 5;6;0;Create;False;0;0;False;0;None;18a1c5cc7397b9847816e03e17440d92;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;105;-1405.134,-1317.521;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;42;-1391.89,397.6553;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-1366.124,-928.462;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;116;-1407.399,2399.641;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;-1420.128,1794.233;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;40;-1403.371,-269.8198;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;104;-1404.443,-1578.265;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;46;-1381.499,1089.289;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;38;-1129.661,-424.5732;Inherit;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;False;0;-1;None;44b550da39bfea448a4be6b25b1b626c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;43;-1129.559,276.5542;Inherit;True;Property;_TextureSample3;Texture Sample 3;0;0;Create;True;0;0;False;0;-1;None;44b550da39bfea448a4be6b25b1b626c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-1157.076,-1643.286;Inherit;True;Property;_CC;CC;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;86;-1145.661,-1380.318;Inherit;True;Property;_ControlEx;ControlEx;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;117;-1101.532,2258.05;Inherit;True;Property;_TextureSample2;Texture Sample 2;0;0;Create;True;0;0;False;0;-1;None;44b550da39bfea448a4be6b25b1b626c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;91;-1110.913,1009.069;Inherit;True;Property;_TextureSample6;Texture Sample 6;0;0;Create;True;0;0;False;0;-1;None;44b550da39bfea448a4be6b25b1b626c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-1134.41,-1133.135;Inherit;True;Property;_Splat0;Splat0;0;0;Create;True;0;0;False;0;-1;None;44b550da39bfea448a4be6b25b1b626c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;87;-1114.262,1660.116;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;-1;None;44b550da39bfea448a4be6b25b1b626c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;60;-1102.047,1524.156;Float;False;Property;_Smoothness3;Smoothness 4;23;0;Create;False;0;0;False;0;0.5;0.442;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;97;-34.67287,530.3898;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;118;-1101.684,2463.427;Inherit;True;Property;_Normal5;Normalmap 6;13;0;Create;False;0;0;False;0;-1;None;3ad3732759f50d64f964c6862190d7cb;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;100;-198.0946,556.248;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;39;-1130.471,-220.5169;Inherit;True;Property;_Normal1;Normalmap 2;9;0;Create;False;0;0;False;0;-1;None;2bfa6ce6a05caeb4f84f99e403361842;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;114;-194.7481,2156.321;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-1129.219,-13.69413;Float;False;Property;_Metallic1;Metallic 2;15;0;Create;False;0;0;False;0;0;0.179;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-1123.59,-626.8615;Float;False;Property;_Smoothness0;Smoothness 1;20;0;Create;False;0;0;False;0;0.5;0.449;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;85;-181.3371,-439.5378;Float;False;return Layer1 * Weight.r + Layer2 * Weight.g + Layer3 * Weight.b + Layer4 * Weight.a + Layer5 * WeightExtra.r + Layer6 * WeightExtra.g@;4;False;8;True;Weight;FLOAT4;0,0,0,0;In;float[5];Half;False;True;WeightExtra;FLOAT4;0,0,0,0;In;;Half;False;True;Layer1;FLOAT4;0,0,0,0;In;;Float;False;True;Layer2;FLOAT4;0,0,0,0;In;;Float;False;True;Layer3;FLOAT4;0,0,0,0;In;;Float;False;True;Layer4;FLOAT4;0,0,0,0;In;;Float;False;True;Layer5;FLOAT4;0,0,0,0;In;;Float;False;True;Layer6;FLOAT4;0,0,0,0;In;;Float;False;Weighted Blend 6;True;False;0;8;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;108;-1096.723,2055.536;Float;False;Property;_Metallic4;Metallic 5;19;0;Create;False;0;0;False;0;0.3988698;0.09;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-1096.979,2135.747;Float;False;Property;_Smoothness4;Smoothness 5;24;0;Create;False;0;0;False;0;0.5;0.442;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;109;-188.1331,1949.997;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-1104.176,1431.739;Float;False;Property;_Metallic3;Metallic 4;18;0;Create;False;0;0;False;0;0;0.09;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;90;-1114.413,1858.02;Inherit;True;Property;_Normal4;Normalmap 5;12;0;Create;False;0;0;False;0;-1;None;3ad3732759f50d64f964c6862190d7cb;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;101;-202.313,703.1569;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-1125.719,-719.2783;Float;False;Property;_Metallic0;Metallic 1;14;0;Create;False;0;0;False;0;0;0.391;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-1113.205,792.0283;Float;False;Property;_Smoothness2;Smoothness 3;22;0;Create;False;0;0;False;0;0.5;0.59;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;44;-1124.177,487.4503;Inherit;True;Property;_Normal2;Normalmap 3;10;0;Create;False;0;0;False;0;-1;None;747ac6003c7d8f24188b85b011b55bc5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;48;-1110.63,1220.124;Inherit;True;Property;_Normal3;Normalmap 4;11;0;Create;False;0;0;False;0;-1;None;f5453dca2ac649e4182c56a3966ad395;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;16;-1131.163,-929.2997;Inherit;True;Property;_Normal0;Normalmap 1;8;0;Create;False;0;0;False;0;-1;None;4d6323c1fc1635443912c9a55a30b876;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;119;-1083.994,2660.944;Float;False;Property;_Metallic5;Metallic 6;17;0;Create;False;0;0;False;0;0;0.09;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;89;-165.2174,-176.3069;Float;False;return Layer1 * Weight.r + Layer2 * Weight.g + Layer3 * Weight.b + Layer4 * Weight.a + Layer5 * WeightExtra.r + Layer6 * WeightExtra.g@;4;False;8;True;Weight;FLOAT4;0,0,0,0;In;float[5];Half;False;True;WeightExtra;FLOAT4;0,0,0,0;In;;Half;False;True;Layer1;FLOAT4;0,0,0,0;In;;Float;False;True;Layer2;FLOAT4;0,0,0,0;In;;Float;False;True;Layer3;FLOAT4;0,0,0,0;In;;Float;False;True;Layer4;FLOAT4;0,0,0,0;In;;Float;False;True;Layer5;FLOAT4;0,0,0,0;In;;Float;False;True;Layer6;FLOAT4;0,0,0,0;In;;Float;False;Weighted Blend 6;True;False;0;8;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;111;739.8605,891.2155;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1115.334,699.6114;Float;False;Property;_Metallic2;Metallic 3;16;0;Create;False;0;0;False;0;0;0.154;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;102;-31.88735,680.0215;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;-1127.09,78.72269;Float;False;Property;_Smoothness1;Smoothness 2;21;0;Create;False;0;0;False;0;0.5;0.366;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;113;740.4531,1059.01;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;112;44.84045,2139.51;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-1084.25,2741.155;Float;False;Property;_Smoothness5;Smoothness 6;25;0;Create;False;0;0;False;0;0.5;0.442;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;110;39.20831,1923.658;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;0,0;Float;False;False;-1;2;ASEMaterialInspector;0;2;Hidden/Templates/LightWeightSRPPBR;1976390536c6c564abb90fe41f6ee334;True;ShadowCaster;0;1;ShadowCaster;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;3;0,0;Float;False;False;-1;2;ASEMaterialInspector;0;2;Hidden/Templates/LightWeightSRPPBR;1976390536c6c564abb90fe41f6ee334;True;Meta;0;3;Meta;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;;0;0;Standard;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;1637.746,648.4337;Float;False;True;-1;2;ASEMaterialInspector;0;2;MTE/LWRP/6 Textures;1976390536c6c564abb90fe41f6ee334;True;Base;0;0;Base;11;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=-100;True;2;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=LightweightForward;False;0;;0;0;Standard;2;Vertex Position,InvertActionOnDeselection;1;Receive Shadows;1;1;_FinalColorxAlpha;0;4;True;True;True;True;False;;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2;0,0;Float;False;False;-1;2;ASEMaterialInspector;0;2;Hidden/Templates/LightWeightSRPPBR;1976390536c6c564abb90fe41f6ee334;True;DepthOnly;0;2;DepthOnly;0;False;False;False;True;0;False;-1;False;False;False;False;False;True;3;RenderPipeline=LightweightPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;2;0;False;False;False;False;True;False;False;False;False;0;False;-1;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;;0;0;Standard;0;0
WireConnection;105;2;106;0
WireConnection;42;2;41;0
WireConnection;28;2;19;0
WireConnection;116;2;115;0
WireConnection;63;2;62;0
WireConnection;40;2;37;0
WireConnection;104;2;103;0
WireConnection;46;2;45;0
WireConnection;38;0;37;0
WireConnection;38;1;40;0
WireConnection;43;0;41;0
WireConnection;43;1;42;0
WireConnection;6;0;103;0
WireConnection;6;1;104;0
WireConnection;86;0;106;0
WireConnection;86;1;105;0
WireConnection;117;0;115;0
WireConnection;117;1;116;0
WireConnection;91;0;45;0
WireConnection;91;1;46;0
WireConnection;5;0;19;0
WireConnection;5;1;28;0
WireConnection;87;0;62;0
WireConnection;87;1;63;0
WireConnection;97;0;6;0
WireConnection;97;1;100;0
WireConnection;118;1;116;0
WireConnection;100;0;53;0
WireConnection;100;1;56;0
WireConnection;100;2;58;0
WireConnection;100;3;61;0
WireConnection;39;1;40;0
WireConnection;114;0;107;0
WireConnection;114;1;120;0
WireConnection;85;0;6;0
WireConnection;85;1;86;0
WireConnection;85;2;5;0
WireConnection;85;3;38;0
WireConnection;85;4;43;0
WireConnection;85;5;91;0
WireConnection;85;6;87;0
WireConnection;85;7;117;0
WireConnection;109;0;108;0
WireConnection;109;1;119;0
WireConnection;90;1;63;0
WireConnection;101;0;54;0
WireConnection;101;1;57;0
WireConnection;101;2;59;0
WireConnection;101;3;60;0
WireConnection;44;1;42;0
WireConnection;48;1;46;0
WireConnection;16;1;28;0
WireConnection;89;0;6;0
WireConnection;89;1;86;0
WireConnection;89;2;16;0
WireConnection;89;3;39;0
WireConnection;89;4;44;0
WireConnection;89;5;48;0
WireConnection;89;6;90;0
WireConnection;89;7;118;0
WireConnection;111;0;97;0
WireConnection;111;1;110;0
WireConnection;102;0;6;0
WireConnection;102;1;101;0
WireConnection;113;0;102;0
WireConnection;113;1;112;0
WireConnection;112;0;6;0
WireConnection;112;1;114;0
WireConnection;110;0;6;0
WireConnection;110;1;109;0
WireConnection;0;0;85;0
WireConnection;0;1;89;0
WireConnection;0;3;111;0
WireConnection;0;4;113;0
ASEEND*/
//CHKSM=571485FEAB749E5BA3E6C92E7E23D08C433EFA8D