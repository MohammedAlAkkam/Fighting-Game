using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class shoppingmanager : MonoBehaviour
{
    delegate void methodtype(int id);
    methodtype SaveData;

    public enum ItemType
    {
         shield = 1
         ,sword = 2
         ,character = 0
    }
    [SerializeField] TMP_Text ItemTypeText;
    [SerializeField] TMP_Text ItemPrice;
    [SerializeField] Image Itemsprite;
    [SerializeField] Dropdown List;
    [SerializeField] GameObject contaniner;
    [SerializeField] TMP_Text Mony;

    [Header("Buttons")]
    [SerializeField] Button leftbtn;
    [SerializeField] Button rightbtn;
    ItemType type;
    ShopItem[] items;
    int index;


    private void OnEnable()
    {
        Mony.text = Player.character.mony.ToString();
        type =(ItemType) List.value;
        items = new ShopItem[0];

        switch (type)
        {
            case ItemType.shield:
                items = PlayerSetup_Manager.manager.shields;
                SaveData = database_manager.SetShield;
                break;
            case ItemType.sword:
                items = PlayerSetup_Manager.manager.swords;
                SaveData = database_manager.SetSword;

                break;
            case ItemType.character:
                items = PlayerSetup_Manager.manager.Characters;
                SaveData = database_manager.Setcharacter;
                break;
            default:
                break;
        }
        ItemTypeText.text = type.ToString();
        index = 0;
        ChangeItem();

    }
    private void ChangeItem()
    {
        Itemsprite.sprite = items[index].image;
        ItemPrice.text = items[index].price.ToString();
        contaniner.SetActive(!items[index].isPurchased);
        
    }
    public void Onclickleftbtn()
    {

        index++;
        if (index >= items.Length) index = 0;
        ChangeItem();
    }
    public void Onclickrightbtn()
    {

        index--;
        if (index < 0) index = items.Length;
        ChangeItem();
    }

    public void EnableUI()
    {
        gameObject.SetActive(true);
    }

    public void DisableUI()
    {
        gameObject.SetActive(false);
    }
    public void OnPriceclick() 
    {
        //SaveData(items[index].ID);
        if (Player.character.mony == 0) return;
        items[index].isPurchased = true;
        contaniner.SetActive(false);
        Player.character.mony -= items[index].price;
        Mony.text = Player.character.mony.ToString();
    }
}