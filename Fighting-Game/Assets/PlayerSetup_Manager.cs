using System.Collections;
using UnityEngine;

public class PlayerSetup_Manager : MonoBehaviour
{
    private void Awake()
    {
        manager = this;
        
    }
    private IEnumerator InitializeShopping()
    {
        yield return new WaitForSeconds(.1f);
        foreach (var item in swords)
        {
            item.isPurchased = database_manager.GetSword(item.ID);
        }
        print("finish");
     
      foreach (Character character in Characters)
      {
          character.isPurchased = database_manager.Getcharacter(character.ID);
         
      }
      print("finish");
     
     
     
      foreach (var item in shields)
      {
          item.isPurchased = database_manager.GetShield(item.ID);
      }
      print("finish");
           



    }
    public void ArrowSetup()
    {
       // StartCoroutine(InitializeShopping());
        //InitializeShopping();
        int shieldCount = 0; 
        int SwordCount = 0;
        int characterCount = 0;
        foreach (var item in shields)
        {
            if (item.isPurchased) shieldCount++;
            if (shieldCount >= 2) ArrowSword.SetActive(true);
            else ArrowSword.SetActive(false);
        }
        foreach (var item in swords)
        {
            if (item.isPurchased) SwordCount++;
           ArrowShield.SetActive(SwordCount >= 2);

        }
        foreach (var item in Characters)
        {
            if (item.isPurchased) characterCount++;
            if (characterCount >= 2) characterchanger.SetActive(true);
        }
        print("finish");
    }
    [SerializeField] PlayerUI playerUI;
    public static PlayerSetup_Manager manager;
    [Header("Containers")]
    public GameObject Shield_Container;
    public GameObject Sowrd_Container;
    public GameObject Character_Container;
    [Header("Arrow")]
    public GameObject ArrowSword;
    public GameObject ArrowShield;
    public GameObject characterchanger;
    GameObject Sowrd_Selected;
    GameObject Shield_Selected;
    [Header("Elements")]
    public Shield []shields;
    public Sword []swords;
    public Character []Characters;

    void SetMesh(GameObject L,GameObject T)
    {

        L.GetComponent<MeshFilter>().sharedMesh = T.GetComponent<MeshFilter>().sharedMesh;
        L.GetComponent<MeshRenderer>().sharedMaterial = T.GetComponent<MeshRenderer>().sharedMaterial;
    }

    public int Shield_Index = -1;
    public int Sowrd_Index = -1;
    public int Character_Index = 1;
    public void ChangeShield()
    {
        ++Shield_Index;
        Shield_Index %=shields.Length;
        while(!shields[Shield_Index].isPurchased)
        {
            ++Shield_Index;
            Shield_Index %= shields.Length;
        }
        Shield_Selected = shields[Shield_Index].model_UI.transform.GetChild(0).gameObject;
        transform.localPosition = Shield_Selected.transform.localPosition;
        Shield_Container.transform.localScale = Shield_Selected.transform.localScale;
        Shield_Container.transform.rotation = Shield_Selected.transform.rotation;
        SetMesh(Shield_Container, Shield_Selected.gameObject);
       // print(playerUI.gameObject.name);
        playerUI.PlayerSetupShield();
    }
    public void ChangeSowrd()
    {
        ++Sowrd_Index;
        Sowrd_Index %= swords.Length;
        while (!swords[Sowrd_Index].isPurchased)
        {
            ++Sowrd_Index;
            Sowrd_Index %= swords.Length;
        }
        Sowrd_Selected = swords[Sowrd_Index].model_UI.transform.GetChild(0).gameObject;
        Sowrd_Container.transform.localPosition = Sowrd_Selected.transform.localPosition;
        Sowrd_Container.transform.localScale = Sowrd_Selected.transform.localScale;
        Sowrd_Container.transform.rotation = Sowrd_Selected.transform.rotation;
        SetMesh(Sowrd_Container, Sowrd_Selected.gameObject);

        playerUI.PlayerSetupSowrd();
    }
    
    public void ChangeCharacter()
    {

        Destroy(Player.character.player);
        ++Character_Index;
        print(Character_Index);
        Character_Index %= 2;
        while (!Characters[Character_Index].isPurchased)
        {
            ++Character_Index;
            Character_Index %= Characters.Length;
        }

        Player.character.player = Instantiate(Characters[Character_Index].model,Character_Container.transform.position,Quaternion.identity);
        playerUI = Player.character.player.GetComponent<PlayerUI>();
        Player.character.player.transform.position =Character_Container.transform.position;
        playerUI.PlayerSetupShield();
        playerUI.PlayerSetupSowrd();
    }
    
    void Start()
    {
        Player.character.player = Instantiate(Characters[0].model,Character_Container.transform.position,Quaternion.identity);
        playerUI = Player.character.player.GetComponent<PlayerUI>();
        ChangeShield();
        ChangeSowrd();
       // ChangeCharacter();

        ArrowSetup();
    }
}
