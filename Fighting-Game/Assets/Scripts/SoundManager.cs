using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;
public class SoundManager : MonoBehaviour
{
    static SoundManager manager;
    public AudioMixerGroup mixer;
    public Sound []sounds;
    private void Awake()
    {
        if (manager == null)
            manager = this;
        else
        {
            Destroy(gameObject);
            return;
        }
        DontDestroyOnLoad(gameObject);
        foreach (Sound s in sounds)
        {
            s.source = gameObject.AddComponent<AudioSource>();
            s.source.clip = s.clip;
            s.source.volume = s.volume;
            s.source.pitch = s.pitch;
            s.source.loop = s.loop;
            s.source.outputAudioMixerGroup = mixer;

        }
    }
    private void Start()
    {
        Play("Explotion");
    }

    public void Play(string name)
    {
        Sound s = System.Array.Find(sounds, ss => ss.name == name);
        if (s == null)
            return;
        s.source.Play();
    }
}
