public class Connection
{
   public byte end;
   public byte weightEncoding;
   public float weight;
   public Connection(byte end, byte weightEncoding)
   {
     this.end = end;
     this.weightEncoding = weightEncoding;
     this.weight = weightEncoding / 100.0;
   }
}