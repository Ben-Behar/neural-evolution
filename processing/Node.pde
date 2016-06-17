public class Node
{
  public byte         id = 0;                        // from 1 to N
  boolean shouldEvaluate = false;                    // Does this node need to be considered for firing?
  float            value = 0;                        // The sum of all recieved signals
  float        threshold = 1;                        // Amount of signal required to "fire" this neuron
  ArrayList<Connection> connections = new ArrayList<Connection>(); // receivers paired with signal weights
  
  public Node(byte id)
  {
    this.id = id;
  }

  public void signal(float level)
  {
    this.shouldEvaluate  = true;
    

    this.value          += level;

    //println(this.id+".signal(" + level + ") -> " + this.value );
    //System.out.println(this.toString() + ":" + level);
  }
  
  public boolean evaluation()
  {
    return this.value > 1;
  }
 
}

public ByteBuffer encodeInto(Node n,ByteBuffer b)
{

   b.put(n.id);                         // local int identifier for the creature
   b.putInt(n.connections.size());         // number of connections
   for(Connection c : n.connections)        
   {
       //println(b);
      b.put(c.end).put(c.weightEncoding);  // connected node id with weight
   }
   return b;
}

public Node decodeFrom(ByteBuffer b)
{
   Node n = new Node(b.get()); // get id
   //println(b);
   for(int i = b.getInt(); i > 0 ; i--)      // get num connections   
      n.connections.add( new Connection( b.get(), b.get()) ); // get node id and weigh
   return n;
}