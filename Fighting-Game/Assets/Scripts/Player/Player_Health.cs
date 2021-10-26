using UnityEngine;
using UnityEngine.UI;
public class Player_Health : MonoBehaviour
{
    float Max_Health = 100;
    float chip_speed;
    public float lerptime;
    public Image FHB;
    public Image BHB;

    public void UpdateHealthBar(float health)
    {
        //print(health);
        float fillF = FHB.fillAmount;
        float fillB = BHB.fillAmount;
        float hFruction = health / Max_Health;
        if (fillB > hFruction)
        {
            BHB.color = Color.red;
            lerptime +=Time.deltaTime;
        float precentcomplet = lerptime ;
        BHB.fillAmount = Mathf.Lerp(fillB,hFruction,precentcomplet);
        FHB.fillAmount = hFruction;

        }
        if (fillF < hFruction)
        {
            BHB.color = Color.green;
            lerptime += Time.deltaTime;
            float precentcomplet = lerptime;
            FHB.fillAmount = Mathf.Lerp(fillF,BHB.fillAmount, precentcomplet);
            BHB.fillAmount = hFruction;
        }
    }

}
