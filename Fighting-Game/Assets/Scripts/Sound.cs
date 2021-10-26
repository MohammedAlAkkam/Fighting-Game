using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;
[System.Serializable]
public class Sound
{
    public string name;
    public AudioSource source;
    public AudioClip clip;
    public float volume;
    public float pitch;
    public bool loop;
}
