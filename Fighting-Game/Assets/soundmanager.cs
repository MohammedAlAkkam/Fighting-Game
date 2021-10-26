using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Audio;
public class soundmanager : MonoBehaviour
{
    public AudioMixer mixer;
    public GameObject setting;
    public Slider slider;

    public void Enable()
    {
        setting.SetActive(true);

    }
    public void disable()
    {
        setting.SetActive(false);
    }
    public void onchanged(float vol)
    {
        mixer.SetFloat("MusicVol", Mathf.Log10(vol) * 20);
        FindObjectOfType<SoundManager>().Play("Attack");

    }
}
