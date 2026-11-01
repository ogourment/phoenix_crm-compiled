defmodule Mix.Tasks.Compile.BinaryPhoenixCrm do
  use Mix.Task.Compiler
  @moduledoc false
  @root __DIR__
  @checksums %{
    "ebin/Elixir.Inspect.PhoenixCRM.Conversation.beam" =>
      "BB3DCC5DCFFFCA6C7AD2351DE89CC5484F31653FE80F091F7B346AB53FDDFA76",
    "ebin/Elixir.Inspect.PhoenixCRM.Message.beam" =>
      "F8E6E2FAC4B619E18097321B877708C706DF86CD7EF2B99D0DD89CFFB0ACC222",
    "ebin/Elixir.PhoenixCRM.Activity.beam" =>
      "4D2DF38AFA4B47196F809BDDA748B30B9C6C6A768BF9FEFA167E8155567532D1",
    "ebin/Elixir.PhoenixCRM.Address.beam" =>
      "7388D19A3E812A9410F7499727C121681390A298D2C5AE6DF91DBC62E4B6789C",
    "ebin/Elixir.PhoenixCRM.AreaRules.beam" =>
      "7235A369A24D24A4C561258820935BA66A82C7FCFEE3025F8128188760E93CE4",
    "ebin/Elixir.PhoenixCRM.ContactLifecycleMigration.beam" =>
      "DCE38F16A4E0D6DD3E15A45E960266CB35FB9F4390451F54458C103A1C8D73CA",
    "ebin/Elixir.PhoenixCRM.ContactSource.beam" =>
      "F6428976D8196618194A06CAC8BE1838785768D328AC9E9FAF6272206759BA5A",
    "ebin/Elixir.PhoenixCRM.Conversation.beam" =>
      "50203989A6210D66FE25771676BC3ABD96BB36F721E378FCB23D96064A602F96",
    "ebin/Elixir.PhoenixCRM.ConversationMigration.beam" =>
      "D752A723BB88E0EC197E9A21C9054721CF2C83660D70676DC68A9364734578D5",
    "ebin/Elixir.PhoenixCRM.Conversations.beam" =>
      "7101765754F16903C434B7B8063AAA28DD0797F936D6474A4CD614757599B4D9",
    "ebin/Elixir.PhoenixCRM.Geography.beam" =>
      "817C013D4954F31D3D4928F0923AB559B555809D0273F3499AD330D45AB25B04",
    "ebin/Elixir.PhoenixCRM.InboundReceiptSchema.beam" =>
      "CB2D50654C3B5143814CD538763BEA46BBC235B1263B7D3338B1D86697EE853F",
    "ebin/Elixir.PhoenixCRM.ListRules.beam" =>
      "0F481CC7C3E39A5796AC7417249A996D3EA19E22892B6AAB55143C563A7A2D89",
    "ebin/Elixir.PhoenixCRM.MailingList.beam" =>
      "D916271FD7DA0CD2D8155D8A3C55CF491610FF8BB1CCE1A1DC637B05CD7D4F1F",
    "ebin/Elixir.PhoenixCRM.MailingListEvent.beam" =>
      "9E79F99523BB270F69D3C98A6614CD7AA9C3D4695EE957389273618D4E2E8F05",
    "ebin/Elixir.PhoenixCRM.MailingLists.beam" =>
      "B7EB752F44064C23A16A1EBFC9D80C412975B99E5AE3DC5C2BD5013BF8A055E0",
    "ebin/Elixir.PhoenixCRM.MailingListsMigration.beam" =>
      "97FA3A638FCE9CEBA8B295CA97F92F71210C30F31347B216090BD6E055709454",
    "ebin/Elixir.PhoenixCRM.Merge.beam" =>
      "934158CD07FC3601D54A92AF142FF091915289431BF77F7E9486693CA2C05F54",
    "ebin/Elixir.PhoenixCRM.Message.beam" =>
      "AC3F8F2F60DFAA45F691594AD13C24E471934389B7AF6164BB862885D2399F91",
    "ebin/Elixir.PhoenixCRM.Migration.beam" =>
      "C120A08B3A641D432124F2B8D977F5B2B44718F95C276A5AB69000B043400A19",
    "ebin/Elixir.PhoenixCRM.Person.beam" =>
      "5D3D85794694E350D7259FA2D3971AD874BDD6FDE75ABC9583E9EFA25AF7605F",
    "ebin/Elixir.PhoenixCRM.Policy.beam" =>
      "8909651CBF082C1512103D87973157A96C8B538AA42C2B4B4E5351B87AA83905",
    "ebin/Elixir.PhoenixCRM.ReceiptStore.beam" =>
      "E1B3996A145076753D9DF4DFE542572BF30F3C0EC103E41542AB6134E1589578",
    "ebin/Elixir.PhoenixCRM.ReplyNotificationSchema.beam" =>
      "43ABF890F88BC28F0109C0F7416DDBB56847FE88EE7286BD09E4EF3D97395DCF",
    "ebin/Elixir.PhoenixCRM.Source.beam" =>
      "2759F097947D8D68336E9961C02E89F4720997FFD06282928EFD5C365C8AD148",
    "ebin/Elixir.PhoenixCRM.SourceMetadata.beam" =>
      "62E35CEDBE05750DD8FA84B1368D04A74D2C51C6723977299755E26419B6BD16",
    "ebin/Elixir.PhoenixCRM.beam" =>
      "4C5389A0720F75A09D923871066F1AF80B8595815C6E6CF1886D503FBDD569B9",
    "ebin/phoenix_crm.app" => "3F74C43C62C0627BEFDA2E145147CF47CD68082CE4AC23D58FC32616FB3F9537"
  }

  @impl true
  def run(_args) do
    series = Version.parse!(System.version()) |> Map.take([:major, :minor])

    unless series == %{major: 1, minor: 20} and System.otp_release() == "29" do
      Mix.raise("phoenix_crm requires a binary distribution for Elixir 1.20.x / OTP 29")
    end

    for {path, expected} <- @checksums do
      bytes = File.read!(Path.join(@root, path))

      unless Base.encode16(:crypto.hash(:sha256, bytes)) == expected do
        Mix.raise("phoenix_crm artifact checksum mismatch: #{path}")
      end

      if String.starts_with?(path, "ebin/") do
        target = Path.join(Mix.Project.compile_path(), Path.basename(path))
        File.mkdir_p!(Path.dirname(target))
        File.write!(target, bytes)
      end
    end

    {:ok, []}
  end
end

defmodule Compiled.PhoenixCrm.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_crm,
      version: "0.0.10",
      elixir: "~> 1.20.0",
      compilers: [:binary_phoenix_crm],
      deps: [ecto_sql: "~> 3.13", jason: "~> 1.4"]
    ]
  end

  def application, do: [extra_applications: [:logger]]
end
