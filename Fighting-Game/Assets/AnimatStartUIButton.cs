using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class AnimatStartUIButton : MonoBehaviour
{
    Image image;
    
    // Start is called before the first frame update
    void Start()
    {
        image = GetComponent<Image>();
    }

    // Update is called once per frame
    void Update()
    {
        image.fillAmount += Time.deltaTime * 2;
        if (image.fillAmount >= 1) enabled = false;
    }
}
