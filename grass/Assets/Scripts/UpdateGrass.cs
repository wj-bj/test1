using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[ExecuteInEditMode]
public class UpdateGrass : MonoBehaviour
{
    public  GameObject obj;
    Material material;
    // Start is called before the first frame update
    void Start()
    {
        if(material == null)
        {
            material = this.GetComponent<MeshRenderer>().sharedMaterial;
        }
    }

    // Update is called once per frame
    void Update()
    {
        if(obj!= null && material!=null)
        {
            Vector3 pos = obj.transform.position;
            pos.y = 0;
            material.SetVector("_Position", pos);
            float v = 0.5f;
            if (Input.GetKey(KeyCode.W))
            {
                Vector3 temp =  obj.transform.position;
                temp += obj.transform.forward*v;
                obj.transform.position = temp;
            }
            else if (Input.GetKey(KeyCode.S))
            {
                Vector3 temp = obj.transform.position;
                temp -= obj.transform.forward * v;
                obj.transform.position = temp;
            }
            else if (Input.GetKey(KeyCode.A))
            {
                Vector3 temp = obj.transform.position;
                temp -= obj.transform.right * v;
                obj.transform.position = temp;
            }
            else if (Input.GetKey(KeyCode.D))
            {
                Vector3 temp = obj.transform.position;
                temp += obj.transform.right * v;
                obj.transform.position = temp;
            }
        }


 
    }
}
