package layoutdeneme;
import java.awt.Dimension;

import javax.swing.GroupLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import static javax.swing.JFrame.EXIT_ON_CLOSE;
import javax.swing.JPanel;
/**
 *
 * @author Yunus Emre
 */
public class GL extends JFrame{
// BURADAN ITIBAREN KOPYALAYABILIRSIN
    public JPanel pOut = new JPanel(); // Panel tanımlaması
   
    public JButton b1 = new JButton("Buton 1"); // Örnek buton 1
    public JButton b2 = new JButton("Buton 2"); // Örnek buton 2
    
    public GroupLayout gl = new GroupLayout(pOut); // Layout'u panele göre tanımlama
    
    GL(){
        pOut.setLayout(gl); // Panel'e layoutu ekleme
        setButton(b1, 100, 30); // Örnek buton1'in oluşturulması
        setButton(b2, 100, 30); // Örnek buton2'in oluşturulması
        setLayout(); // Layout'u düzenleme
        build(); // Ekrana çizilmesini sağlayan metodlar.
    }

    
    public final void setButton(JButton btn, int x, int y){
        btn.setMinimumSize(new Dimension(x, y)); // Buton'un en küçük boyutu
    }
    
    public final void setLayout(){ // Layout oluşturulması (Önemli)
        
        gl.setHorizontalGroup( // Yatayda tasarım oluşturma
                gl.createSequentialGroup() // Seri tasarım grubu (eklenen öğeler birbirine seri olur)
                    .addComponent(b1) // Buton1 'in eklenmesi
                    .addComponent(b2)); // Buton2 'in eklenmesi
        
        gl.setVerticalGroup( // Dikeyde tasarım oluşturma
                gl.createParallelGroup() // Paralel tasarım grubu (eklenen öğeler birbirine paralel olur)
                    .addComponent(b1) // Buton1 'in eklenmesi
                    .addComponent(b2)); // Buton2 'in eklenmesi
    }
    
    public final void build(){
        add(pOut); // Frame'e panelin eklenmesi
        setDefaultCloseOperation(EXIT_ON_CLOSE); // Frame'i X'a basınca kapatma
        pack(); // Frame'i otomatik boyutlandırma
        setVisible(true);
    }
    public static void main(String[] args) {
// GL ADLI KISMA KENDİ CLASS İSMİNİ YAZMAN GEREKMEKTE
        GL frame = new GL(); // Frame'in oluşturulması
        frame.setLocationRelativeTo(null); // Frame'i ekranın tam ortasına çizdirme
    }
}
