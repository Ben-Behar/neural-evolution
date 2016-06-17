import java.nio.*;

void setup()
{
  ByteBuffer bs = ByteBuffer.allocate(100);
  bs.put((byte)69).putInt(2)
  .put((byte)2).put((byte)69)
  .put((byte)69).put((byte)255).flip();
 // println(bs);
   println(Math.random()*255);
  println(hexOf((byte) 39));
  Creature c = decode(bs);

  
  
  c = ex3();
  //println(encode(c));
  c.network.get(0).value = 10; // bump the network
  //// // // / / // // / // / / / /
  Node endNode;
  for(int i =0 ; i < 100; i++)
  {
    //c.network.get(0).signal(.1);
    for(Node n : c.network)
    {
      //println(n.id + "::" + n.value);
      if(n.evaluation())
      {
        for(Connection con : n.connections)
          if(null != (endNode = c.getNode(con.end))) // only use valid connections
          {
            print(hexOf(n.id)+"--{" + con.weight * n.value + "}--> " + hexOf(con.end) );
            endNode.signal(con.weight * n.value); // we send the value * the connection weight
            println(" == " + endNode.value);
          }
        n.value = 0;
      }
      //else print("NO" + n.id + "|");
    }
  }
  println("YAAYAY");
  exit();
}

void draw()
{
  
}

void println(ByteBuffer bb)
{
  int i = bb.position();
  int j = bb.limit();
  ByteBuffer b = ByteBuffer.wrap(bb.array());
  print("ByteBuffer:");
  while( 0 < b.remaining())
  {
    if(i-- == 0) print("[");
    if(j-- == 0) print("]");
    print(hexOf(b.get()));
    print(" ");
  }
  println("|");
}

byte randByte()
{
  return (byte)Math.round(Math.random()*255);
}
String hexOf(byte b)
{
  return String.format("%X", b);
}

Creature ex1()
{
  Creature c = new Creature();
  Node n1 = new Node((byte)1);
  Node n2 = new Node((byte)2);
  n1.connections.add(new Connection(n2.id, (byte) 50 ));
  n2.connections.add(new Connection(n1.id, (byte) 1 ));
  c.network.add(n1);
  c.network.add(n2);
  return c;
}

Creature ex2()
{
    Creature c = null;
    while(c == null)
    {
      try{
        int limit = (int)Math.round(Math.random()*255);
        ByteBuffer b = ByteBuffer.allocate(limit+1);
        while( 0 < b.remaining())
          b.put(randByte());
        println("I made dis:");
        println(b);
        b.flip();
        c = decode(b);
      }
      catch(Exception e) {print(".");}
    }
  return c;
}

Creature ex3()
{
    Creature c = null;
    while(c == null)
    {
      try{
        int size = 0;
        int [] struct = new int[(int)Math.round(Math.random()*100)]; // how many nodes total
        for(int i = 0 ; i < struct.length; i++)
          size += 
            1 + // id (1 byte)
            4 + // numConnections (4 byte * 1 int)
            2 * (struct[i] = (int) Math.round(Math.random()*100)); // 2byte * connections

        ByteBuffer b = ByteBuffer.allocate(size);
        
        for(int i = 0 ; i < struct.length; i++)
        {
          b.put(randByte());
          b.putInt(struct[i]);
          for(int j = 0; j < struct[i] ; j ++)
          {
            b.put(randByte());
            b.put(randByte());
          }
        }

        b.flip();
        c = decode(b);
      }
      catch(Exception e) {print(".");}
    }
  println("I made dis:");
  println(encode(c));
  return c;
}