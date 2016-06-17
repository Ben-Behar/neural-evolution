public class Creature
{
  ArrayList<Node> network = new ArrayList<Node>();
  
  public int sizeEstimate()
  {
    int i = 0;
    for(Node n : this.network)
      i += + 1 + 4 +(2 * n.connections.size()); //byte int (byte int) * N
    return i;
  }
  
  public Node getNode(byte id)
  {
    for(Node n : this.network)
      if(n.id == id)
        return n;
    return null;
  }
}

  
  
/* * * CREATURE * * *
 * A Creature can be represented as a mere network of parts.
 * Each part represents a flavor of anatomy, simplified to senses, motors, and neural centers 
 * Self References?
 */
 
 
public Creature decode(ByteBuffer bs)
{
  Creature c = new Creature();
  while(0 < bs.remaining())
    c.network.add(decodeFrom(bs));
  return c;
}


public ByteBuffer encode(Creature creature)
{
  ByteBuffer bs = ByteBuffer.allocate(creature.sizeEstimate());
  for( Node a : creature.network)
    encodeInto(a,bs);
  bs.flip();
  return bs;
}


  
  