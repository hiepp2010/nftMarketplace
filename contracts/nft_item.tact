import "@stdlib/deploy";
import "@stdlib/ownable";
import "./messages.tact";

contract NftItem with Deployable, OwnableTransferable {
    // Empty init() function is present by default in all Tact contracts
    // since v1.3.0, so the following may be omitted:
    //
    // init() {}

    owner: Address;
    collectionAddress: Address;
    itemIndex: Int;
    individualContent: String;

    init(owner: Address, collectionAddress: Address, itemIndex: Int, individualContent: String){
        self.owner = owner;
        self.collectionAddress = collectionAddress;
        self.itemIndex = itemIndex;
        self.individualContent = individualContent;
    }

    receive(msg: Transfer){
        self.requireOwner();
        self.owner = msg.newOwner;
    }

}
