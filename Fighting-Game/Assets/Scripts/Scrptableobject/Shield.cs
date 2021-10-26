using UnityEngine;

[CreateAssetMenu(fileName = "Shield", menuName = "Card/Shield")]
public class Shield : ShopItem
{
    public GameObject model;
    public GameObject model_UI;
    [Range(0, 1)] public float damageable;
}