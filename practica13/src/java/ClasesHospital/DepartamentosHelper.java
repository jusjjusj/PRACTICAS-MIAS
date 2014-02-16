package ClasesHospital;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

public class DepartamentosHelper 
{
    Session session = null;
    org.hibernate.Transaction tx = null;
    public DepartamentosHelper() 
    {
        this.iniciarConexion();
    }
    
    private void iniciarConexion()
    {
        this.session = HibernateUtil.getSessionFactory().getCurrentSession();
        this.tx = session.beginTransaction();
    } 

    public List getDepartamentos() 
    {
        List<Dept> listadepartamentos = null;
        try 
        {
            if (!this.session.isOpen())
            {
                this.iniciarConexion();
            }
Query consulta = session.createQuery("from Dept as dept order by dept.deptNo");
            listadepartamentos = (List<Dept>) consulta.list();
        } catch (Exception ex) 
        {
            System.out.println("Excepcion LISTANDO DEPARTAMENTOS: " + ex);
        }
        return listadepartamentos;
    } 
    
    public void eliminarDepartamento(int num) 
    {
        try
        {
            this.tx = session.beginTransaction();
            Dept d = (Dept)session.load(Dept.class,(byte)num);
            session.delete(d);
            tx.commit();
        } catch (Exception ex) 
        {
            System.out.println("Excepcion ELIMINANDO: " + ex);
        }           
    }

    public void insertarDepartamento(int num, String nom, String loc) 
    {
        try 
        {
            this.tx = session.beginTransaction();
            Dept d = new Dept();
            d.setDeptNo((byte)num);
            d.setDnombre(nom);
            d.setLoc(loc);
            session.save(d);
            tx.commit();
        } catch (Exception ex) 
        {
            System.out.println("Excepcion INSERTANDO: " + ex);
        }
    }

    public void modificarDepartamento(int num, String nom, String loc) 
    {
        try
        {
            this.tx = session.beginTransaction();
            Dept d = (Dept)session.load(Dept.class,(byte)num);
            d.setDnombre(nom);
            d.setLoc(loc);
            session.update(d);
            tx.commit();
            //session.close();
        } catch (Exception ex) 
        {
            System.out.println("Excepcion MODIFICANDO: " + ex);
        }           
    }

    
}

