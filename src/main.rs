use futures::{SinkExt, StreamExt};
use tokio::net::{TcpListener, TcpStream};
use tokio_websockets::{Error, ServerBuilder};

#[tokio::main]
async fn main() -> Result<(), Error> {
    let listener = TcpListener::bind("127.0.0.1:3000").await.unwrap();

    loop {
        let (socket, _) = listener.accept().await.unwrap();
        tokio::spawn(async move {
            process(socket).await;
        });
    }
}

async fn process(socket: TcpStream) {
    let mut server = ServerBuilder::new().accept(socket).await.unwrap();

    while let Some(Ok(item)) = server.next().await {
        println!("Received: {item:?}");
        server.send(item).await.unwrap();
    }
}
